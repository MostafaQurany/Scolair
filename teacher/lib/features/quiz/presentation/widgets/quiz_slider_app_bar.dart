import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../../core/localization/localization_extension.dart';

class SliderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SliderAppBar({
    required this.currentIndex, required this.total, required this.onDelete, super.key,
    this.onBank,
  });

  final int currentIndex;
  final int total;
  final VoidCallback onDelete;
  final VoidCallback? onBank;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),

        onPressed: () => Navigator.pop(context),
      ),
      leadingWidth: 40.w,
      title: Text(
        context.l10n.questionOfTotal(currentIndex + 1, total),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 1.w),
      actions: [
        if (onBank != null)
          IconButton(
            onPressed: onBank,
            icon: Icon(Icons.library_books_outlined, size: 16.r),
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
