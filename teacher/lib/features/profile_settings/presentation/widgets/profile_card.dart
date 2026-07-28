import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../domain/entities/user_profile.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({required this.profile, super.key});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      // padding: EdgeInsets.all(20.w),
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [
      //       colors.primaryContainer.withValues(alpha: 0.4),
      //       colors.surface,
      //     ],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //   ),
      //   borderRadius: BorderRadius.circular(20.r),
      //   border: Border.all(color: colors.primary.withValues(alpha: 0.15)),
      // ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 36.r,
                backgroundColor: colors.primary,
                child: profile.displayImageUrl?.isNotEmpty == true
                    ? ClipOval(
                        child: AppCachedNetworkImage(
                          imageUrl: profile.displayImageUrl!,
                          width: 72.r,
                          height: 72.r,
                        ),
                      )
                    : Text(
                        profile.displayedName.isNotEmpty
                            ? profile.displayedName[0].toUpperCase()
                            : 'T',
                        style: textTheme.headlineMedium?.copyWith(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRouteNames.editProfile),
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.surface, width: 2),
                    ),
                    child: Icon(
                      Icons.edit_rounded,
                      size: 14.sp,
                      color: colors.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(width: 16.w),
          // Expanded(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         profile.displayedName,
          //         style: textTheme.titleMedium?.copyWith(
          //           fontWeight: FontWeight.w700,
          //           color: colors.onSurface,
          //         ),
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //       if (profile.displayedSubtitle != null) ...[
          //         SizedBox(height: 4.h),
          //         Text(
          //           profile.displayedSubtitle!,
          //           style: textTheme.bodySmall?.copyWith(
          //             color: colors.onSurfaceVariant,
          //           ),
          //           maxLines: 2,
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //       ],
          //     ],
          //   ),
          // ),
          // IconButton(
          //   onPressed: () =>
          //       Navigator.pushNamed(context, AppRouteNames.editProfile),
          //   icon: Icon(
          //     Icons.arrow_forward_ios_rounded,
          //     size: 18.sp,
          //     color: colors.onSurfaceVariant,
          //   ),
          // ),
        ],
      ),
    );
  }
}
