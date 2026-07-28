// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../cubit/authenticated_user_cubit.dart';
import '../cubit/authenticated_user_state.dart';
import '../widgets/edit_profile_form.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _headlineController;
  late final TextEditingController _bioController;
  late final TextEditingController _linkedinController;
  late final TextEditingController _githubController;
  late final TextEditingController _twitterController;

  String? _selectedOpenTo;
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    final profile = getIt<AuthenticatedUserCubit>().currentProfile;
    _firstNameController = TextEditingController(
      text: profile?.firstName ?? '',
    );
    _lastNameController = TextEditingController(text: profile?.lastName ?? '');
    _headlineController = TextEditingController(text: profile?.headline ?? '');
    _bioController = TextEditingController(text: profile?.bio ?? '');
    _linkedinController = TextEditingController(text: profile?.linkedin ?? '');
    _githubController = TextEditingController(text: profile?.github ?? '');
    _twitterController = TextEditingController(text: profile?.twitter ?? '');
    final openToVal = profile?.openTo;
    _selectedOpenTo = (openToVal == 'Work' || openToVal == 'Hiring')
        ? openToVal
        : 'None';

    _firstNameController.addListener(_markDirty);
    _lastNameController.addListener(_markDirty);
    _headlineController.addListener(_markDirty);
    _bioController.addListener(_markDirty);
    _linkedinController.addListener(_markDirty);
    _githubController.addListener(_markDirty);
    _twitterController.addListener(_markDirty);
  }

  void _markDirty() {
    if (!_isDirty) {
      setState(() => _isDirty = true);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _headlineController.dispose();
    _bioController.dispose();
    _linkedinController.dispose();
    _githubController.dispose();
    _twitterController.dispose();
    super.dispose();
  }

  Future<void> _handlePop() async {
    if (!_isDirty) {
      Navigator.pop(context);
      return;
    }
    final discard = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final colorScheme = Theme.of(dialogContext).colorScheme;
        final textTheme = Theme.of(dialogContext).textTheme;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text(
            dialogContext.l10n.editProfileDirtyWarningTitle,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          content: Text(
            dialogContext.l10n.editProfileDirtyWarningMessage,
            style: textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(dialogContext.l10n.editProfileDirtyWarningKeep),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
              ),
              child: Text(dialogContext.l10n.editProfileDirtyWarningDiscard),
            ),
          ],
        );
      },
    );
    if (discard == true && mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _pickAndUploadImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp'],
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      if (file.lengthSync() <= 5 * 1024 * 1024) {
        if (mounted) {
          AppSnackBar.showInfo(context, context.l10n.editProfileSaving);
        }
        await getIt<AuthenticatedUserCubit>().uploadAvatar(file);
      } else {
        if (mounted) {
          AppSnackBar.showError(context, context.l10n.editProfileImageTooLarge);
        }
      }
    }
  }

  Future<void> _saveProfile() async {
    final success = await getIt<AuthenticatedUserCubit>().updateProfile(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      headline: _headlineController.text.trim(),
      bio: _bioController.text.trim(),
      openTo: (_selectedOpenTo == 'None' || _selectedOpenTo == null)
          ? ''
          : _selectedOpenTo,
      linkedin: _linkedinController.text.trim(),
      github: _githubController.text.trim(),
      twitter: _twitterController.text.trim(),
    );
    if (success && mounted) {
      setState(() => _isDirty = false);
      AppSnackBar.showSuccess(context, context.l10n.editProfileSavedSuccess);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: !_isDirty,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _handlePop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.editProfileScreenTitle),
          centerTitle: true,
          leading: BackButton(
            color: colorScheme.primary,
            onPressed: _handlePop,
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<AuthenticatedUserCubit, AuthenticatedUserState>(
            bloc: getIt<AuthenticatedUserCubit>(),
            listener: (context, state) {
              state.whenOrNull(
                error: (message, _) => AppSnackBar.showError(context, message),
              );
            },
            builder: (context, state) {
              final isUpdating = state.maybeWhen(
                loading: () => true,
                loaded: (_, isUpdating) => isUpdating,
                orElse: () => false,
              );
              final profile = getIt<AuthenticatedUserCubit>().currentProfile;

              return EditProfileForm(
                profile: profile,
                isUpdating: isUpdating,
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                headlineController: _headlineController,
                bioController: _bioController,
                linkedinController: _linkedinController,
                githubController: _githubController,
                twitterController: _twitterController,
                selectedOpenTo: _selectedOpenTo,
                onOpenToChanged: (value) {
                  if (value == _selectedOpenTo) return;
                  setState(() {
                    _selectedOpenTo = value;
                    _isDirty = true;
                  });
                },
                onPickImage: _pickAndUploadImage,
                onSave: _saveProfile,
              );
            },
          ),
        ),
      ),
    );
  }
}
