import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/localization/localization_extension.dart';
import '../../../../../core/storage/app_secure_storage.dart';
import '../../../../../core/theme/app_colors.dart';
import 'frappe_file_url_resolver.dart';

class UploadVideoBlockWidget extends StatefulWidget {
  const UploadVideoBlockWidget({
    required this.fileUrl,
    required this.fileType,
    super.key,
  });

  final String fileUrl;
  final String fileType;

  @override
  State<UploadVideoBlockWidget> createState() => _UploadVideoBlockWidgetState();
}

class _UploadVideoBlockWidgetState extends State<UploadVideoBlockWidget> {
  BetterPlayerController? _controller;
  bool _isLoading = true;
  bool _hasError = false;
  int _initRequestId = 0;

  String get _fileName {
    final path =
        Uri.tryParse(widget.fileUrl)?.path ?? widget.fileUrl.split('?').first;

    final parts = path.split('/').where((part) => part.isNotEmpty).toList();

    if (parts.isEmpty) {
      return widget.fileUrl;
    }

    return Uri.decodeComponent(parts.last);
  }

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  @override
  void didUpdateWidget(covariant UploadVideoBlockWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.fileUrl != widget.fileUrl) {
      _initPlayer();
    }
  }

  @override
  void dispose() {
    _initRequestId++;
    _controller?.dispose(forceDispose: true);
    _controller = null;
    super.dispose();
  }

  Future<void> _initPlayer() async {
    final requestId = ++_initRequestId;
    final oldController = _controller;

    setState(() {
      _controller = null;
      _isLoading = true;
      _hasError = false;
    });

    _disposeControllerAfterFrame(oldController);

    try {
      final resolvedUrl = FrappeFileUrlResolver.resolve(widget.fileUrl).trim();

      if (resolvedUrl.isEmpty || Uri.tryParse(resolvedUrl) == null) {
        _setError(requestId);
        return;
      }

      final token = await getIt<AppSecureStorage>().readAccessToken();

      if (!mounted || requestId != _initRequestId) return;

      final dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        resolvedUrl,
        headers: _authHeaders(token),
        videoExtension: _videoExtension(resolvedUrl),
        bufferingConfiguration: const BetterPlayerBufferingConfiguration(
          minBufferMs: 15000,
          maxBufferMs: 50000,
          bufferForPlaybackMs: 1500,
          bufferForPlaybackAfterRebufferMs: 3000,
        ),
      );
      final controller = BetterPlayerController(
        BetterPlayerConfiguration(
          aspectRatio: 16 / 9,
          fullScreenAspectRatio: 16 / 9,
          fit: BoxFit.contain,
          autoDispose: false,
          allowedScreenSleep: false,
          expandToFill: false,
          placeholder: const _PlayerLoader(),
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableSkips: false,
            progressBarPlayedColor: AppColors.primary,
            progressBarHandleColor: AppColors.primary,
            progressBarBufferedColor: AppColors.primary.withValues(alpha: 0.35),
            progressBarBackgroundColor: Colors.white.withValues(alpha: 0.25),
            loadingWidget: const _PlayerLoader(),
          ),
          eventListener: (event) => _handlePlayerEvent(event, requestId),
          errorBuilder: (context, errorMessage) => _ErrorCard(
            fileName: _fileName,
            fileType: widget.fileType,
            onRetry: _initPlayer,
          ),
        ),
        betterPlayerDataSource: dataSource,
      );

      if (!mounted || requestId != _initRequestId) {
        controller.dispose(forceDispose: true);
        return;
      }

      setState(() {
        _controller = controller;
        _isLoading = false;
      });
    } catch (_) {
      _setError(requestId);
    }
  }

  Map<String, String>? _authHeaders(String? token) {
    final cleanToken = token?.trim();

    if (cleanToken == null || cleanToken.isEmpty) {
      return null;
    }

    return {'Authorization': 'Bearer $cleanToken'};
  }

  String? _videoExtension(String url) {
    final path = Uri.tryParse(url)?.path ?? url.split('?').first;
    final fileName = path.split('/').last;
    final dotIndex = fileName.lastIndexOf('.');

    if (dotIndex == -1 || dotIndex == fileName.length - 1) {
      return null;
    }

    return fileName.substring(dotIndex + 1).toLowerCase();
  }

  void _handlePlayerEvent(BetterPlayerEvent event, int requestId) {
    if (!mounted || requestId != _initRequestId) return;

    switch (event.betterPlayerEventType) {
      case BetterPlayerEventType.exception:
        _setError(requestId);
        break;
      case BetterPlayerEventType.initialized:
        if (_hasError || _isLoading) {
          setState(() {
            _hasError = false;
            _isLoading = false;
          });
        }
        break;
      default:
        break;
    }
  }

  void _setError(int requestId) {
    if (!mounted || requestId != _initRequestId) return;

    final oldController = _controller;

    setState(() {
      _controller = null;
      _isLoading = false;
      _hasError = true;
    });

    _disposeControllerAfterFrame(oldController);
  }

  void _disposeControllerAfterFrame(BetterPlayerController? controller) {
    if (controller == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.dispose(forceDispose: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return _ErrorCard(
        fileName: _fileName,
        fileType: widget.fileType,
        onRetry: _initPlayer,
      );
    }

    if (_isLoading || _controller == null) {
      return const _VideoLoadingPlaceholder();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: BetterPlayer(
          key: ValueKey(widget.fileUrl),
          controller: _controller!,
        ),
      ),
    );
  }
}

class _VideoLoadingPlaceholder extends StatelessWidget {
  const _VideoLoadingPlaceholder();

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: const AspectRatio(
        aspectRatio: 16 / 9,
        child: ColoredBox(color: Colors.black, child: _PlayerLoader()),
      ),
    );
}

class _PlayerLoader extends StatelessWidget {
  const _PlayerLoader();

  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator(color: Colors.white));
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({
    required this.fileName,
    required this.fileType,
    required this.onRetry,
  });

  final String fileName;
  final String fileType;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cleanFileType = fileType.trim();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_circle,
                color: colorScheme.primary,
                size: 28.r,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (cleanFileType.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      cleanFileType.toUpperCase(),
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                  SizedBox(height: 4.h),
                  Text(
                    context.l10n.unableToStreamPrivateFile,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            IconButton(onPressed: onRetry, icon: const Icon(Icons.refresh)),
          ],
        ),
      ),
    );
  }
}
