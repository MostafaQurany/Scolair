import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
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
  YoutubePlayerController? _controller;
  String? _videoId;

  @override
  void initState() {
    super.initState();
    _videoId = YouTubeIdExtractor.extract(widget.source);
    if (_videoId != null) {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: _videoId!,
        autoPlay: false,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          enableJavaScript: true,
          // playsInline forces the iframe API to render inline inside the
          // WebView surface — without it the video plays in a detached native
          // layer (audio only, black screen) on both Android and iOS.
          playsInline: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (_controller == null) {
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        child: ListTile(
          leading: const Icon(Icons.warning, color: Colors.amber),
          title: Text(context.l10n.youtubeVideoLink),
          subtitle: Text(
            widget.source,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.source));
              AppSnackBar.showSuccess(context, context.l10n.linkCopied);
            },
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // YoutubePlayerScaffold ensures the controller context is wired to the
        // platform view before the first frame, preventing a black screen on
        // first load (especially on Android where surface attachment is async).
        YoutubePlayerScaffold(
          controller: _controller!,
          aspectRatio: 16 / 9,
          builder: (context, player) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: player,
            );
          },
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
        if (widget.caption != null && widget.caption!.isNotEmpty) ...[
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

  Future<void> _openExternally() async {
    final videoId = _videoId;
    final uri = videoId == null
        ? Uri.tryParse(widget.source)
        : Uri.parse('https://www.youtube.com/watch?v=$videoId');
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
