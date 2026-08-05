import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../../core/localization/localization_extension.dart';

class SliderBottomBar extends StatelessWidget {
  const SliderBottomBar({required this.currentIndex, required this.isLastSlide, required this.onBack, required this.onNext, required this.onAddNew, required this.onDone, required this.onSave, super.key,
  });

  final int currentIndex;
  final bool isLastSlide;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onAddNew;
  final VoidCallback onDone;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
        ),
        child: Row(
          children: [
            TextButton(
              onPressed: currentIndex > 0 ? onBack : null,
              child: Text(context.l10n.back),
            ),
            const Spacer(),
            if (isLastSlide) ...[
              FilledButton(onPressed: onDone, child: Text(context.l10n.done)),
              SizedBox(width: 8.w),
              OutlinedButton(
                onPressed: onAddNew,
                child: Text(context.l10n.addNew),
              ),
            ] else ...[
              OutlinedButton(
                onPressed: onSave,
                child: Text(context.l10n.saveLocally),
              ),
              SizedBox(width: 8.w),
              FilledButton(onPressed: onNext, child: Text(context.l10n.next)),
            ],
          ],
        ),
      ),
    );
}
