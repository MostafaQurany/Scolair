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
import '../widgets/homework_segment_bar.dart';
import 'homework_form_screen.dart';

/// Lists all homework items for the teacher, grouped by status.
///
/// Uses a pill [HomeworkSegmentBar] inside the body instead of a
/// [TabBar] to avoid truncation and visual crowding in the [AppBar].
class HomeworkListScreen extends StatefulWidget {
  const HomeworkListScreen({super.key});

  @override
  State<HomeworkListScreen> createState() => _HomeworkListScreenState();
}

class _HomeworkListScreenState extends State<HomeworkListScreen> {
  final _pageController = PageController();
  final _selectedSegment = ValueNotifier<int>(0);

  @override
  void dispose() {
    _pageController.dispose();
    _selectedSegment.dispose();
    super.dispose();
  }

  void _onSegmentChanged(int index) {
    _selectedSegment.value = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

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
    return BlocProvider(
      create: (_) => getIt<HomeworkListCubit>()..loadHomework(),
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.homeworkManagementTitle)),
        body: SafeArea(
          child: BlocBuilder<HomeworkListCubit, HomeworkListState>(
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

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.homeworkMockBreadcrumb,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
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
                  // Pill segment bar lives inside the body.
                  ValueListenableBuilder<int>(
                    valueListenable: _selectedSegment,
                    builder: (context, selected, _) => HomeworkSegmentBar(
                      selectedIndex: selected,
                      publishedCount: published.length,
                      draftCount: drafts.length,
                      scheduledCount: scheduled.length,
                      onChanged: _onSegmentChanged,
                    ),
                  ),
                  Expanded(
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              _selectedSegment.value = index;
                            },
                            children: [
                              _HomeworkList(homework: published),
                              _HomeworkList(homework: drafts),
                              _HomeworkList(homework: scheduled),
                            ],
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HomeworkList extends StatelessWidget {
  const _HomeworkList({required this.homework});

  final List<HomeworkModel> homework;

  Future<void> _editHomework(
    BuildContext context,
    HomeworkModel item,
  ) async {
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
              await context
                  .read<HomeworkListCubit>()
                  .duplicateHomework(item.id);
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
