import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';

class WallPostBody extends StatefulWidget {
  const WallPostBody({required this.body, required this.hashtags, super.key});

  final String body;
  final List<String> hashtags;

  @override
  State<WallPostBody> createState() => _WallPostBodyState();
}

class _WallPostBodyState extends State<WallPostBody> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // A simple heuristic: if body is long, show expand toggle
    final isLong =
        widget.body.length > 160 || widget.body.split('\n').length > 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.body,
          style: textTheme.bodyMedium?.copyWith(
            height: 1.4,
            color: colorScheme.onSurface,
          ),
          maxLines: _isExpanded ? null : 4,
          overflow: _isExpanded ? TextOverflow.clip : TextOverflow.ellipsis,
        ),
        if (isLong) ...[
          SizedBox(height: 4.h),
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Text(
              _isExpanded
                  ? context.l10n.postShowLess
                  : context.l10n.postReadMore,
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        if (widget.hashtags.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 4.h,
            children: widget.hashtags.map((tag) => Text(
                '#$tag',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              )).toList(),
          ),
        ],
      ],
    );
  }
}
