import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:scolair_teacher/core/widgets/app_cached_network_image.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/courses_models.dart';
import '../../domain/usecases/courses_usecases.dart';
import '../screens/course_form_screen.dart';
import 'forms/delete_confirmation_dialog.dart';

/// A redesigned course card matching the "My Courses" mockup — a colored
/// accent bar, a subject icon tile, category label + title + instructor
/// subtitle, and a footer of bordered stat tiles.
class ModernCourseCard extends StatelessWidget {
  const ModernCourseCard({
    required this.course,
    required this.onTap,
    this.canManage = false,
    this.onChanged,
    super.key,
  });

  final CourseModel course;
  final VoidCallback onTap;
  final bool canManage;
  final VoidCallback? onChanged;

  Future<void> _onEdit(BuildContext context) async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CourseFormScreen(editingCourse: course),
      ),
    );
    if (updated == true) onChanged?.call();
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
        onChanged?.call();
      },
      failure: (fail) => AppSnackBar.showError(context, fail.message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accent = _CourseVisuals.color(course.category, colorScheme);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4.w, color: accent),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Header(
                        course: course,
                        accent: accent,
                        canManage: canManage,
                        onEdit: () => _onEdit(context),
                        onDelete: () => _onDelete(context),
                      ),
                      SizedBox(height: 16.h),
                      _StatsRow(course: course, accent: accent),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.course,
    required this.accent,
    required this.canManage,
    required this.onEdit,
    required this.onDelete,
  });

  final CourseModel course;
  final Color accent;
  final bool canManage;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final subtitle = _subtitle(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48.r,
          height: 48.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: AppCachedNetworkImage(
              imageUrl: course.image?.trim() ?? '',
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
              errorWidget: Icon(
                _CourseVisuals.icon(course.category),
                size: 24.r,
                color: accent,
              ),
            ),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (course.category != null)
                Text(
                  course.category!.toUpperCase(),
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              SizedBox(height: 2.h),
              Text(
                course.title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) ...[
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: accent,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        if (canManage)
          PopupMenuButton<String>(
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
              PopupMenuItem(
                value: 'edit',
                child: Text(context.l10n.editCourse),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text(
                  context.l10n.deleteCourseConfirmTitle,
                  style: TextStyle(color: colorScheme.error),
                ),
              ),
            ],
          )
        else
          Icon(
            Icons.chevron_right,
            size: 22.r,
            color: colorScheme.outlineVariant,
          ),
      ],
    );
  }

  String? _subtitle(BuildContext context) {
    final instructors = course.instructors ?? const [];
    if (instructors.length > 1) {
      final names = instructors
          .map((i) => i.fullName ?? i.firstName ?? i.username ?? '')
          .where((n) => n.isNotEmpty)
          .toList();
      if (names.isNotEmpty) {
        return context.l10n.myCoursesCoTaughtBy(names.join(', '));
      }
    } else if (instructors.length == 1) {
      final name =
          instructors.first.fullName ??
          instructors.first.firstName ??
          instructors.first.username;
      if (name != null && name.isNotEmpty) return name;
    }
    final intro = course.shortIntroduction?.trim();
    return (intro != null && intro.isNotEmpty) ? intro : null;
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.course, required this.accent});

  final CourseModel course;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(
            icon: Icons.menu_book_outlined,
            value: '${course.lessons ?? 0}',
            label: context.l10n.coursesLessonsLabel,
            color: accent,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _StatTile(
            icon: Icons.people_outline,
            value: '${course.enrollments ?? 0}',
            label: context.l10n.coursesStudentsLabel,
            color: accent,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _StatTile(
            icon: Icons.star_outline,
            value: _formatRating(course.rating),
            label: context.l10n.coursesRatingLabel,
            color: AppColors.warning,
          ),
        ),
      ],
    );
  }

  String _formatRating(dynamic rating) {
    if (rating == null) return '0.0';
    if (rating is num) return rating.toStringAsFixed(1);
    if (rating is String) {
      final parsed = double.tryParse(rating);
      return parsed != null ? parsed.toStringAsFixed(1) : rating;
    }
    return '0.0';
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 18.r, color: color),
          SizedBox(height: 6.h),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Resolves an accent color and icon for a course based on its category.
abstract final class _CourseVisuals {
  static const _palette = [
    Color(0xFF003EB3),
    Color(0xFF006875),
    AppColors.tertiary,
    Color(0xFF6D28D9),
    Color(0xFF0E7490),
  ];

  static Color color(String? category, ColorScheme colorScheme) {
    final key = category?.toLowerCase() ?? '';
    if (key.contains('math') || key.contains('calc')) {
      return const Color(0xFF003EB3);
    }
    if (key.contains('phys') ||
        key.contains('science') ||
        key.contains('chem') ||
        key.contains('bio')) {
      return const Color(0xFF006875);
    }
    if (key.contains('lit') ||
        key.contains('english') ||
        key.contains('history')) {
      return AppColors.tertiary;
    }
    if (category == null || category.isEmpty) return colorScheme.primary;
    return _palette[category.hashCode.abs() % _palette.length];
  }

  static IconData icon(String? category) {
    final key = category?.toLowerCase() ?? '';
    if (key.contains('math') || key.contains('calc')) {
      return Icons.calculate_outlined;
    }
    if (key.contains('phys')) return Icons.science_outlined;
    if (key.contains('chem')) return Icons.biotech_outlined;
    if (key.contains('bio')) return Icons.eco_outlined;
    if (key.contains('science')) return Icons.science_outlined;
    if (key.contains('lit') || key.contains('english')) {
      return Icons.menu_book_outlined;
    }
    if (key.contains('history')) return Icons.history_edu_outlined;
    if (key.contains('art')) return Icons.palette_outlined;
    if (key.contains('music')) return Icons.music_note_outlined;
    return Icons.school_outlined;
  }
}
