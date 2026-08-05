import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../domain/entities/user_profile.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.profile,
    required this.isUpdating,
    required this.firstNameController,
    required this.lastNameController,
    required this.headlineController,
    required this.bioController,
    required this.linkedinController,
    required this.githubController,
    required this.twitterController,
    required this.selectedOpenTo,
    required this.onOpenToChanged,
    required this.onPickImage,
    required this.onSave,
    super.key,
  });

  final UserProfile? profile;
  final bool isUpdating;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController headlineController;
  final TextEditingController bioController;
  final TextEditingController linkedinController;
  final TextEditingController githubController;
  final TextEditingController twitterController;
  final String? selectedOpenTo;
  final ValueChanged<String?> onOpenToChanged;
  final VoidCallback onPickImage;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: isUpdating ? null : onPickImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 46.r,
                    backgroundColor: colors.primaryContainer,
                    child: profile?.displayImageUrl?.isNotEmpty ?? false
                        ? ClipOval(
                            child: AppCachedNetworkImage(
                              imageUrl: profile!.displayImageUrl,
                              width: 92.r,
                              height: 92.r,
                            ),
                          )
                        : Icon(
                            Icons.person_rounded,
                            size: 46.sp,
                            color: colors.primary,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.surface, width: 2),
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 16.sp,
                        color: colors.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          _field(
            context.l10n.editProfileFirstName,
            Icons.person_outline_rounded,
            firstNameController,
          ),
          _gap,
          _field(
            context.l10n.editProfileLastName,
            Icons.person_outline_rounded,
            lastNameController,
          ),
          _gap,
          _field(
            context.l10n.editProfileHeadline,
            Icons.work_outline_rounded,
            headlineController,
          ),
          _gap,
          _field(
            context.l10n.editProfileBio,
            Icons.info_outline_rounded,
            bioController,
            maxLines: 4,
          ),
          _gap,
          DropdownButtonFormField<String>(
            initialValue: selectedOpenTo,
            decoration: InputDecoration(
              labelText: context.l10n.editProfileOpenTo,
              prefixIcon: const Icon(Icons.handshake_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            items: [
              DropdownMenuItem(
                value: 'Work',
                child: Text(context.l10n.editProfileOpenToWork),
              ),
              DropdownMenuItem(
                value: 'Hiring',
                child: Text(context.l10n.editProfileOpenToHiring),
              ),
              DropdownMenuItem(
                value: 'None',
                child: Text(context.l10n.editProfileOpenToNone),
              ),
            ],
            onChanged: onOpenToChanged,
          ),
          _gap,
          _field(
            context.l10n.editProfileLinkedin,
            Icons.link_rounded,
            linkedinController,
          ),
          _gap,
          _field(
            context.l10n.editProfileGithub,
            Icons.code_rounded,
            githubController,
          ),
          _gap,
          _field(
            context.l10n.editProfileTwitter,
            Icons.alternate_email_rounded,
            twitterController,
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: isUpdating ? null : onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: isUpdating
                  ? SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: CircularProgressIndicator(
                        color: colors.onPrimary,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      context.l10n.editProfileSaveButton,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.onPrimary,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  static const _gap = SizedBox(height: 16);

  Widget _field(
    String label,
    IconData icon,
    TextEditingController controller, {
    int maxLines = 1,
  }) => TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
      ),
    );
}
