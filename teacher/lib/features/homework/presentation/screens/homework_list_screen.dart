import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/homework_models.dart';
import '../cubit/homework_list_cubit.dart';
import '../cubit/homework_list_state.dart';
import '../widgets/homework_card.dart';
import '../widgets/homework_status_tab_bar.dart';
import 'homework_form_screen.dart';

class HomeworkListScreen extends StatelessWidget {
  const HomeworkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeworkListCubit>()..loadHomework(),
      child: const _HomeworkListView(),
    );
  }
}

class _HomeworkListView extends StatelessWidget {
  const _HomeworkListView();

  Future<void> _createHomework(BuildContext context) async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const HomeworkFormScreen()),
    );
    if (created == true && context.mounted) {
      context.read<HomeworkListCubit>().loadHomework();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeworkListCubit, HomeworkListState>(
      builder: (context, state) {
        final homework = state.homework ?? const [];
        final published = homework
            .where((h) => h.status == HomeworkStatus.published)
            .toList();
        final drafts = homework
            .where((h) => h.status == HomeworkStatus.draft)
            .toList();
        final scheduled = homework
            .where((h) => h.status == HomeworkStatus.scheduled)
            .toList();

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.homeworkManagementTitle),
              bottom: HomeworkStatusTabBar(
                publishedCount: published.length,
                draftCount: drafts.length,
                scheduledCount: scheduled.length,
              ),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.homeworkMockBreadcrumb,
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        SizedBox(height: 12.h),
                        FilledButton.icon(
                          onPressed: () => _createHomework(context),
                          icon: const Icon(Icons.add),
                          label: Text(context.l10n.homeworkCreateButton),
                          style: FilledButton.styleFrom(
                            minimumSize: Size(double.infinity, 48.h),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : TabBarView(
                            children: [
                              _HomeworkList(homework: published),
                              _HomeworkList(homework: drafts),
                              _HomeworkList(homework: scheduled),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HomeworkList extends StatelessWidget {
  const _HomeworkList({required this.homework});

  final List<HomeworkModel> homework;

  Future<void> _editHomework(BuildContext context, HomeworkModel item) async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => HomeworkFormScreen(editingHomework: item),
      ),
    );
    if (updated == true && context.mounted) {
      context.read<HomeworkListCubit>().loadHomework();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (homework.isEmpty) {
      return Center(child: Text(context.l10n.homeworkEmptyMessage));
    }

    return RefreshIndicator(
      onRefresh: context.read<HomeworkListCubit>().loadHomework,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: homework.length,
        itemBuilder: (context, index) {
          final item = homework[index];
          return HomeworkCard(
            homework: item,
            onEdit: () => _editHomework(context, item),
            onDuplicate: () async {
              await context.read<HomeworkListCubit>().duplicateHomework(
                item.id,
              );
              if (context.mounted) {
                AppSnackBar.showSuccess(
                  context,
                  context.l10n.homeworkDuplicatedSuccess,
                );
              }
            },
            onDelete: () =>
                context.read<HomeworkListCubit>().deleteHomework(item.id),
          );
        },
      ),
    );
  }
}
