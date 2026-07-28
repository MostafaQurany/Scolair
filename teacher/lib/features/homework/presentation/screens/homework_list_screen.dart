import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../domain/entities/homework_list_item.dart';
import '../cubit/homework_list_cubit.dart';
import '../cubit/homework_list_state.dart';
import '../widgets/homework_card.dart';
import '../widgets/homework_list_shimmer.dart';
import '../widgets/homework_status_dropdown.dart';

class HomeworkListScreen extends StatefulWidget {
  const HomeworkListScreen({super.key});

  @override
  State<HomeworkListScreen> createState() => _HomeworkListScreenState();
}

class _HomeworkListScreenState extends State<HomeworkListScreen> {
  late final HomeworkListCubit _cubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = getIt<HomeworkListCubit>()..loadInitial();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.extentAfter < 500) {
      _cubit.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    _cubit.close();
    super.dispose();
  }

  Future<void> _createHomework() async {
    final created = await Navigator.pushNamed(
      context,
      AppRouteNames.homeworkCreate,
    );
    if (created == true && mounted) await _cubit.refresh();
  }

  Future<void> _openDetails(HomeworkListItem item) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRouteNames.homeworkDetails,
      arguments: item.name,
    );
    if (changed == true && mounted) await _cubit.refresh();
  }

  Future<void> _editHomework(HomeworkListItem item) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRouteNames.homeworkEdit,
      arguments: item,
    );
    if (changed == true && mounted) await _cubit.refresh();
  }

  Future<void> _confirmDelete(HomeworkListItem item) async {
    final title = item.title.isEmpty
        ? context.l10n.homeworkUntitled
        : item.title;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(dialogContext.l10n.homeworkDeleteConfirmTitle),
        content: Text(dialogContext.l10n.homeworkDeleteConfirmMessage(title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(dialogContext.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
            ),
            child: Text(dialogContext.l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final deleted = await _cubit.deleteHomework(item.name);
    if (deleted && mounted) {
      AppSnackBar.showSuccess(context, context.l10n.homeworkDeletedSuccess);
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _cubit,
    child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _createHomework,
        tooltip: context.l10n.homeworkCreateButton,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocConsumer<HomeworkListCubit, HomeworkListState>(
          listenWhen: (previous, current) =>
              previous.errorSerial != current.errorSerial,
          listener: (context, state) {
            final message = state.paginationErrorMessage ?? state.errorMessage;
            if (message != null && state.items.isNotEmpty) {
              AppSnackBar.showError(context, message);
            }
          },
          builder: (context, state) => LayoutBuilder(
            builder: (context, constraints) {
              final useGrid = constraints.maxWidth >= 700;
              return RefreshIndicator(
                onRefresh: _cubit.refresh,
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      title: Text(context.l10n.homeworkManagementTitle),
                    ),
                    SliverToBoxAdapter(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1100),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              16.w,
                              16.h,
                              16.w,
                              12.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HomeworkStatusDropdown(
                                  value: state.filter,
                                  onChanged: _cubit.changeFilter,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (state.isInitialLoading && state.items.isEmpty)
                      SliverPadding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          16.w,
                          4.h,
                          16.w,
                          96.h,
                        ),
                        sliver: HomeworkListShimmer(useGrid: useGrid),
                      )
                    else if (state.hasBlockingError)
                      _HomeworkErrorSliver(
                        message: state.errorMessage!,
                        onRetry: _cubit.retry,
                      )
                    else if (state.items.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsetsDirectional.all(24.r),
                            child: Text(
                              context.l10n.homeworkEmptyMessage,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          16.w,
                          4.h,
                          16.w,
                          16.h,
                        ),
                        sliver: useGrid
                            ? SliverGrid.builder(
                                itemCount: state.items.length,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 520.w,
                                      mainAxisExtent: 390.h,
                                      crossAxisSpacing: 16.w,
                                      mainAxisSpacing: 16.h,
                                    ),
                                itemBuilder: (context, index) => HomeworkCard(
                                  homework: state.items[index],
                                  onViewDetails: () =>
                                      _openDetails(state.items[index]),
                                  onEdit: () =>
                                      _editHomework(state.items[index]),
                                  onDelete: () =>
                                      _confirmDelete(state.items[index]),
                                  isDeleting: state.deletingNames.contains(
                                    state.items[index].name,
                                  ),
                                ),
                              )
                            : SliverList.separated(
                                itemCount: state.items.length,
                                itemBuilder: (context, index) => HomeworkCard(
                                  homework: state.items[index],
                                  onViewDetails: () =>
                                      _openDetails(state.items[index]),
                                  onEdit: () =>
                                      _editHomework(state.items[index]),
                                  onDelete: () =>
                                      _confirmDelete(state.items[index]),
                                  isDeleting: state.deletingNames.contains(
                                    state.items[index].name,
                                  ),
                                ),
                                separatorBuilder: (_, _) =>
                                    SizedBox(height: 14.h),
                              ),
                      ),
                    if (state.items.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(bottom: 96.h),
                          child: _PaginationFooter(
                            state: state,
                            onRetry: _cubit.loadMore,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}

class _HomeworkErrorSliver extends StatelessWidget {
  const _HomeworkErrorSliver({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => SliverFillRemaining(
    hasScrollBody: false,
    child: Center(
      child: Padding(
        padding: EdgeInsetsDirectional.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 48.r,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 12.h),
            Text(message, textAlign: TextAlign.center),
            SizedBox(height: 16.h),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    ),
  );
}

class _PaginationFooter extends StatelessWidget {
  const _PaginationFooter({required this.state, required this.onRetry});

  final HomeworkListState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (state.isLoadingMore) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.paginationErrorMessage != null) {
      return Center(
        child: TextButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: Text(context.l10n.retry),
        ),
      );
    }
    if (!state.hasNextPage) {
      return Center(child: Text(context.l10n.homeworkEndOfResults));
    }
    return const SizedBox.shrink();
  }
}
