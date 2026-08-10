import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/extensions/adaptive_layout_extension.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/question_form_cubit.dart';
import '../cubit/question_form_state.dart';
import '../widgets/question_form_body.dart';

/// Screen for creating or editing a standalone question.
/// Questions are independent from quizzes in the API.
class QuestionFormScreen extends StatefulWidget {
  const QuestionFormScreen({this.editingQuestion, super.key});

  final QuestionModel? editingQuestion;

  @override
  State<QuestionFormScreen> createState() => _QuestionFormScreenState();
}

class _QuestionFormScreenState extends State<QuestionFormScreen> {
  final GlobalKey<QuestionFormBodyState> _bodyKey =
      GlobalKey<QuestionFormBodyState>();

  bool get _isEditing => widget.editingQuestion != null;

  void _submit(BuildContext context) {
    final bodyData = _bodyKey.currentState?.getFormData();
    if (bodyData == null) return;

    final cubit = context.read<QuestionFormCubit>();
    if (_isEditing) {
      cubit.updateQuestion(bodyData);
    } else {
      cubit.createQuestion(bodyData);
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<QuestionFormCubit>(),
    child: Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(
            _isEditing
                ? context.l10n.questionEditTitle
                : context.l10n.questionAddTitle,
          ),
          actions: [
            TextButton(
              onPressed: () => _submit(context),
              child: Text(context.l10n.save),
            ),
          ],
        ),
        body: _FormBody(
          bodyKey: _bodyKey,
          editingQuestion: widget.editingQuestion,
        ),
        bottomNavigationBar: _FormBottomBar(
          isEditing: _isEditing,
          onSave: () => _submit(context),
          onDelete: _isEditing ? () => Navigator.pop(context) : null,
        ),
      ),
    ),
  );
}

class _FormBody extends StatelessWidget {
  const _FormBody({required this.bodyKey, required this.editingQuestion});

  final GlobalKey<QuestionFormBodyState> bodyKey;
  final QuestionModel? editingQuestion;

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTabletLayout;

    return BlocConsumer<QuestionFormCubit, QuestionFormState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (question) {
            AppSnackBar.showSuccess(context, context.l10n.questionSavedSuccess);
            Navigator.pop(context, question);
          },
          error: (message) => AppSnackBar.showError(context, message),
        );
      },
      builder: (context, state) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isTablet ? 720.w : double.infinity,
          ),
          child: QuestionFormBody(
            key: bodyKey,
            initialQuestion: editingQuestion,
          ),
        ),
      ),
    );
  }
}

class _FormBottomBar extends StatelessWidget {
  const _FormBottomBar({
    required this.isEditing,
    required this.onSave,
    this.onDelete,
  });

  final bool isEditing;
  final VoidCallback onSave;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 14.h + bottomPadding),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
      ),
      child: Row(
        children: [
          if (isEditing && onDelete != null)
            IconButton(
              icon: Icon(Icons.delete_outline, color: colorScheme.error),
              onPressed: onDelete,
            ),
          if (isEditing) SizedBox(width: 8.w),
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.cancel),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: BlocBuilder<QuestionFormCubit, QuestionFormState>(
              builder: (context, state) {
                final isLoading = state.maybeWhen(
                  submitting: () => true,
                  orElse: () => false,
                );
                return FilledButton(
                  onPressed: isLoading ? null : onSave,
                  child: isLoading
                      ? SizedBox(
                          width: 20.r,
                          height: 20.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(context.l10n.questionSaveButton),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
