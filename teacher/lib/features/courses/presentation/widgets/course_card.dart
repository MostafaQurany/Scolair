import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/courses_models.dart';
import '../../domain/usecases/courses_usecases.dart';
import '../screens/course_details_screen.dart';
import '../screens/course_form_screen.dart';
import 'forms/delete_confirmation_dialog.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    required this.course,
    this.canManage = false,
    this.onTap,
    this.onDeleted,
    this.onEdited,
    super.key,
  });

  final CourseModel course;
  final bool canManage;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final VoidCallback? onEdited;

  Future<void> _onEdit(BuildContext context) async {
    final updated = await Navigator.pushNamed(
      context,
      AppRouteNames.courseForm,
      arguments: course,
    );
    if (updated == true) onEdited?.call();
  }

  Future<void> _onDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => DeleteConfirmationDialog(
        title: context.l10n.deleteCourseConfirmTitle,
        body: context.l10n.deleteCourseConfirmBody,
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final result = await getIt<DeleteCourseUseCase>().call(course.name);
    if (!context.mounted) return;

    result.when(
      success: (_) {
        AppSnackBar.showSuccess(context, context.l10n.courseDeletedSuccess);
        onDeleted?.call();
      },
      failure: (fail) => AppSnackBar.showError(context, fail.message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isRed = course.cardGradient?.toLowerCase() == 'red';
    final cardGradient = isRed
        ? const LinearGradient(
            colors: [Color(0xFFE52D27), Color(0xFFB31217)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [colorScheme.primary, colorScheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap:
            onTap ??
            () {
              Navigator.pushNamed(
                context,
                AppRouteNames.courseDetails,
                arguments: course.name,
              );
            },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CourseBanner(course: course, gradient: cardGradient),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (course.shortIntroduction != null) ...[
                    SizedBox(height: 6.h),
                    Text(
                      course.shortIntroduction!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: 12.h),
                  const Divider(),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      _InfoTile(
                        icon: Icons.list,
                        label: context.l10n.coursesLessonsCount(
                          course.lessons ?? 0,
                        ),
                      ),
                      const Spacer(),
                      _InfoTile(
                        icon: Icons.people,
                        label: context.l10n.coursesEnrollmentsCount(
                          course.enrollments ?? 0,
                        ),
                      ),
                      const Spacer(),
                      _InfoTile(
                        icon: Icons.star,
                        label: _formatRating(course.rating),
                        iconColor: AppColors.warning,
                      ),
                      if (canManage) ...[
                        const Spacer(),
                        _CourseManageMenu(
                          onEdit: () => _onEdit(context),
                          onDelete: () => _onDelete(context),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatRating(dynamic rating) {
    if (rating == null) return '0.0';
    if (rating is num) return rating.toStringAsFixed(1);
    if (rating is String) {
      final parsed = double.tryParse(rating);
      if (parsed != null) return parsed.toStringAsFixed(1);
      return rating;
    }
    return '0.0';
  }
}

class _CourseManageMenu extends StatelessWidget {
  const _CourseManageMenu({required this.onEdit, required this.onDelete});

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        size: 20.r,
        color: colorScheme.onSurfaceVariant,
      ),
      padding: EdgeInsets.zero,
      onSelected: (value) {
        if (value == 'edit') onEdit();
        if (value == 'delete') onDelete();
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'edit', child: Text(context.l10n.editCourse)),
        PopupMenuItem(
          value: 'delete',
          child: Text(
            context.l10n.deleteCourseConfirmTitle,
            style: TextStyle(color: colorScheme.error),
          ),
        ),
      ],
    );
  }
}

class _CourseBanner extends StatelessWidget {
  const _CourseBanner({required this.course, required this.gradient});

  final CourseModel course;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final imageUrl = course.image == null
        ? null
        : (course.image!.contains('http') || course.image!.contains('https'))
        ? course.image!
        : '${ApiEndpoints.baseUrl}${course.image!}';

    return SizedBox(
      height: 120.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(decoration: BoxDecoration(gradient: gradient)),
          if (imageUrl != null)
            AppCachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: 120.h,
              fit: BoxFit.cover,
              errorWidget: const SizedBox.shrink(),
            ),
          Container(color: Colors.black.withValues(alpha: 0.15)),
          PositionedDirectional(
            top: 12.h,
            end: 12.w,
            child: _StatusPill(status: course.status),
          ),
          if (course.category != null)
            PositionedDirectional(
              bottom: 12.h,
              start: 12.w,
              child: _CategoryPill(category: course.category!),
            ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final String? status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _statusColor(status).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status ?? context.l10n.coursesDefaultStatusActive,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _statusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return AppColors.success;
      case 'in progress':
        return AppColors.warning;
      default:
        return AppColors.primary;
    }
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        category,
        style: TextStyle(color: Colors.white, fontSize: 11.sp),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.label, this.iconColor});

  final IconData icon;
  final String label;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;

    return Row(
      children: [
        Icon(icon, size: 16.r, color: iconColor ?? color),
        SizedBox(width: 4.w),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
