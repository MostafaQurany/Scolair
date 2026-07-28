import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/localization/localization_extension.dart';
import '../../../../quiz/presentation/cubit/quizzes_cubit.dart';
import '../../../../quiz/presentation/cubit/quizzes_state.dart';

class QuizSelectionDialog extends StatefulWidget {
  const QuizSelectionDialog({super.key});

  @override
  State<QuizSelectionDialog> createState() => _QuizSelectionDialogState();
}

class _QuizSelectionDialogState extends State<QuizSelectionDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => getIt<QuizzesCubit>()..loadQuizzes(),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          width: 0.8.sw,
          constraints: BoxConstraints(maxHeight: 0.7.sh),
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.selectQuizTitle,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: context.l10n.searchQuizHint,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocBuilder<QuizzesCubit, QuizzesState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.errorMessage != null) {
                      return Center(
                        child: Text(
                          state.errorMessage!,
                          style: TextStyle(color: colorScheme.error),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    final quizzes = state.quizzes?.items ?? [];
                    final filteredQuizzes = quizzes.where((q) {
                      return q.title.toLowerCase().contains(_searchQuery) ||
                          q.name.toLowerCase().contains(_searchQuery);
                    }).toList();

                    if (filteredQuizzes.isEmpty) {
                      return Center(
                        child: Text(context.l10n.noQuizzesFound),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: filteredQuizzes.length,
                      separatorBuilder: (_, _) => const Divider(),
                      itemBuilder: (context, index) {
                        final quiz = filteredQuizzes[index];
                        return ListTile(
                          title: Text(
                            quiz.title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            quiz.name,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context, quiz.name);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.l10n.cancel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
