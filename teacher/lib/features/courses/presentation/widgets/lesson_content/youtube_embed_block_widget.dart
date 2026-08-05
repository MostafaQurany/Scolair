import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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
    _initPlayer();
  }

  void _initPlayer() {
    final videoId = YouTubeIdExtractor.extract(widget.source)?.trim();
    _videoId = videoId;

    if (videoId != null && videoId.isNotEmpty) {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        params: const YoutubePlayerParams(
          showFullscreenButton: true,
        ),
      );
    }
  }

  @override
  void didUpdateWidget(covariant YoutubeEmbedBlockWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source != widget.source) {
      _initPlayer();
    }
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final videoId = _videoId;

    if (videoId == null || videoId.isEmpty || controller == null) {
      return Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            const Icon(Icons.video_library_outlined, color: Colors.red),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Invalid YouTube URL: ${widget.source}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: YoutubePlayer(
            controller: controller,
          ),
        ),
        if (widget.caption != null && widget.caption!.trim().isNotEmpty) ...[
          SizedBox(height: 6.h),
          Text(
            widget.caption!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
