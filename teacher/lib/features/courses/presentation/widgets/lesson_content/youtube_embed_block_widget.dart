import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../../../../../core/localization/localization_extension.dart';
import '../../../../../core/widgets/app_snack_bar.dart';
import 'lesson_content_helpers.dart';
import 'youtube_id_extractor.dart';

class YoutubeEmbedBlockWidget extends StatefulWidget {
  const YoutubeEmbedBlockWidget({
    required this.source,
    this.caption,
    super.key,
  });

  final String source;
  final String? caption;

  @override
  State<YoutubeEmbedBlockWidget> createState() =>
      _YoutubeEmbedBlockWidgetState();
}

class _YoutubeEmbedBlockWidgetState extends State<YoutubeEmbedBlockWidget> {
  WebViewController? _controller;
  String? _videoId;
  bool _hasMainFrameError = false;

  @override
  void initState() {
    super.initState();
    _setupPlayer(widget.source);
  }

  @override
  void didUpdateWidget(covariant YoutubeEmbedBlockWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.source != widget.source) {
      _setupPlayer(widget.source);
    }
  }

  void _setupPlayer(String source) {
    final videoId = YouTubeIdExtractor.extract(source)?.trim();

    _videoId = videoId;
    _controller = null;
    _hasMainFrameError = false;

    if (videoId == null || videoId.isEmpty) {
      return;
    }

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            if (error.isForMainFrame ?? true) {
              if (!mounted) return;
              setState(() {
                _hasMainFrameError = true;
              });
            }
          },
        ),
      )
      ..loadHtmlString(
        _buildYoutubeHtml(videoId),
        baseUrl: 'https://www.youtube.com',
      );

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(kDebugMode);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final videoId = _videoId;

    if (videoId == null || videoId.isEmpty || controller == null) {
      return _InvalidYoutubeLinkCard(source: widget.source);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ColoredBox(
              color: Colors.black,
              child: _hasMainFrameError
                  ? _YoutubeErrorFallback(onOpenExternally: _openExternally)
                  : _buildWebView(controller),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton.icon(
            onPressed: _openExternally,
            icon: const Icon(Icons.open_in_new),
            label: Text(context.l10n.openVideo),
          ),
        ),
        if (widget.caption != null && widget.caption!.trim().isNotEmpty) ...[
          SizedBox(height: 8.h),
          Text(
            LessonContentHelpers.stripHtml(widget.caption!),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  Widget _buildWebView(WebViewController controller) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return WebViewWidget.fromPlatformCreationParams(
        params: AndroidWebViewWidgetCreationParams(
          controller: controller.platform,
          displayWithHybridComposition: true,
        ),
      );
    }

    return WebViewWidget(controller: controller);
  }

  String _buildYoutubeHtml(String videoId) {
    final safeVideoId = Uri.encodeComponent(videoId);

    return '''
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      html, body {
        margin: 0;
        padding: 0;
        background-color: #000000;
        height: 100%;
        width: 100%;
        overflow: hidden;
      }

      iframe {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        border: 0;
      }
    </style>
  </head>
  <body>
    <iframe
      src="https://www.youtube.com/embed/$safeVideoId?playsinline=1&rel=0&modestbranding=1"
      title="YouTube video player"
      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
      allowfullscreen>
    </iframe>
  </body>
</html>
''';
  }

  Future<void> _openExternally() async {
    final videoId = _videoId;
    final uri = videoId == null
        ? Uri.tryParse(widget.source)
        : Uri.https('www.youtube.com', '/watch', {'v': videoId});

    if (uri == null) return;

    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!opened && mounted) {
      AppSnackBar.showError(context, context.l10n.authErrorGeneric);
    }
  }
}

class _YoutubeErrorFallback extends StatelessWidget {
  const _YoutubeErrorFallback({required this.onOpenExternally});

  final VoidCallback onOpenExternally;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: onOpenExternally,
        icon: const Icon(Icons.open_in_new),
        label: Text(context.l10n.openVideo),
      ),
    );
  }
}

class _InvalidYoutubeLinkCard extends StatelessWidget {
  const _InvalidYoutubeLinkCard({required this.source});

  final String source;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: ListTile(
        leading: Icon(Icons.warning, color: colorScheme.error),
        title: Text(context.l10n.youtubeVideoLink),
        subtitle: Text(source, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: source));
            AppSnackBar.showSuccess(context, context.l10n.linkCopied);
          },
        ),
      ),
    );
  }
}
