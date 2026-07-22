import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../../core/localization/localization_extension.dart';

class SliderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SliderAppBar({
    required this.currentIndex,
    required this.total,
    required this.onDelete,
    this.onBank,
  });

  final int currentIndex;
  final int total;
  final VoidCallback onDelete;
  final VoidCallback? onBank;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      leadingWidth: 20.w,
      title: Text(
        context.l10n.questionOfTotal(currentIndex + 1, total),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 1.w),
      actions: [
        if (onBank != null)
          TextButton.icon(
            onPressed: onBank,
            icon: Icon(Icons.library_books_outlined, size: 16.r),
            label: Text(context.l10n.questionBankTitle),
          ),
        IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: Theme.of(context).colorScheme.error,
          ),
          onPressed: onDelete,
        ),
      ],
    );
  }
}
