import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../domain/entities/homework_list_item.dart';
import '../cubit/homework_form_cubit.dart';
import '../cubit/homework_form_state.dart';
import '../widgets/forms/homework_form_body.dart';

class HomeworkFormScreen extends StatelessWidget {
  const HomeworkFormScreen({this.editingHomework, super.key});

  final HomeworkListItem? editingHomework;

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) {
        final cubit = getIt<HomeworkFormCubit>();
        if (editingHomework != null) {
          cubit.initForEdit(editingHomework!);
        }
        return cubit;
      },
      child: BlocConsumer<HomeworkFormCubit, HomeworkFormState>(
        listener: (context, state) {
          if (state.status == HomeworkFormStatus.failure && state.errorMessage != null) {
            AppSnackBar.showError(context, state.errorMessage!);
          } else if (state.status == HomeworkFormStatus.success) {
            if (state.isEditing) {
              AppSnackBar.showSuccess(context, context.l10n.edit);
              Navigator.of(context).pop(true);
            } else if (state.createdHomeworkName != null) {
              AppSnackBar.showSuccess(context, context.l10n.homeworkCreatedSuccess);
              Navigator.of(context).pushReplacementNamed(
                AppRouteNames.homeworkDetails,
                arguments: state.createdHomeworkName,
              );
            } else {
              AppSnackBar.showSuccess(context, context.l10n.homeworkCreatedSuccess);
              Navigator.of(context).pop(true);
            }
          }
        },
        builder: (context, state) {
          final isSubmitting = state.status == HomeworkFormStatus.submitting;

          return Scaffold(
            appBar: AppBar(
              title: Text(state.isEditing ? context.l10n.edit : context.l10n.homeworkAddFileTitle),
              elevation: 0,
            ),
            body: Column(
              children: [
                const Expanded(child: HomeworkFormBody()),
                _buildBottomBar(context, state, isSubmitting),
              ],
            ),
          );
        },
      ),
    );

  Widget _buildBottomBar(BuildContext context, HomeworkFormState state, bool isSubmitting) {
    final colors = Theme.of(context).colorScheme;
    final cubit = context.read<HomeworkFormCubit>();

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.outlineVariant)),
      ),
      child: Row(
        children: [
          if (!state.isEditing) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: (!state.isFormValid || isSubmitting) ? null : () => cubit.submitForm(publish: false),
                child: isSubmitting
                    ? SizedBox(width: 20.w, height: 20.h, child: const CircularProgressIndicator(strokeWidth: 2))
                    : Text(context.l10n.homeworkSaveDraft),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 2,
              child: FilledButton(
                onPressed: (!state.isFormValid || isSubmitting) ? null : () => cubit.submitForm(publish: true),
                child: isSubmitting
                    ? SizedBox(width: 20.w, height: 20.h, child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(context.l10n.homeworkPublishAndContinue),
              ),
            ),
          ] else ...[
            Expanded(
              child: FilledButton(
                onPressed: (!state.isFormValid || isSubmitting) ? null : () => cubit.submitForm(publish: false),
                child: isSubmitting
                    ? SizedBox(width: 20.w, height: 20.h, child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(context.l10n.homeworkSaveChanges),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
