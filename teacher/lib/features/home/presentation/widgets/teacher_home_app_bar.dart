import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_route_names.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_user_avatar.dart';
import '../../domain/entities/teacher_profile.dart';

class TeacherHomeAppBar extends StatelessWidget {
  const TeacherHomeAppBar({
    required this.teacher,
    required this.hasUnreadNotifications,
    this.showBackButton = false,
    super.key,
  });

  final TeacherProfile teacher;
  final bool hasUnreadNotifications;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      pinned: false,
      floating: true,
      elevation: 0,
      scrolledUnderElevation: 1,
      automaticallyImplyLeading: showBackButton,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: Image.asset(
              AppAssets.logo,
              width: 32.r,
              height: 32.r,
              errorBuilder: (_, _, _) => Icon(
                Icons.school_outlined,
                size: 24.r,
                color: colorScheme.primary,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            'Scolair',
            style: GoogleFonts.spaceMono(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.notifications_none_outlined, size: 24.r),
              tooltip: context.l10n.notificationsBadgeSemantic,
              onPressed: () {
                Navigator.pushNamed(context, AppRouteNames.organizationNotices);
              },
            ),
            if (hasUnreadNotifications)
              Positioned(
                top: 8.r,
                right: 8.r,
                child: Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: BoxDecoration(
                    color: colorScheme.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(end: 16.w, start: 8.w),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRouteNames.teacherProfile);
            },
            child: Semantics(
              label: context.l10n.teacherAvatarSemantic,
              button: true,
              child: AppUserAvatar(
                imageUrl: teacher.imageUrl,
                displayName: teacher.displayName,
                userId: teacher.id,
                radius: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
