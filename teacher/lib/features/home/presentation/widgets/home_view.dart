import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../domain/entities/teacher_home.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'organization_notice_card.dart';
import 'teacher_feed_filter_list.dart';
import 'teacher_greeting_section.dart';
import 'teacher_home_empty_view.dart';
import 'teacher_home_error_view.dart';
import 'teacher_home_skeleton.dart';
import 'teacher_home_app_bar.dart';
import 'teacher_wall_post_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({this.embedded = false, super.key});

  final bool embedded;

  List<Widget> _buildHeaderSlivers({
    required BuildContext context,
    required TeacherHome home,
    required String selectedFilterId,
    required double bottomSpacing,
  }) {
    return [
      TeacherHomeAppBar(
        teacher: home.teacher,
        hasUnreadNotifications: home.organizationNoticeCount > 0,
        showBackButton: !embedded,
      ),
      SliverToBoxAdapter(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600.w),
            child: TeacherGreetingSection(
              teacherName: home.teacher.displayName,
              greetingActivityTitle: home.greetingActivityTitle,
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600.w),
            child: OrganizationNoticeCard(
              noticeCount: home.organizationNoticeCount,
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600.w),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                TeacherFeedFilterList(
                  filters: home.filters,
                  selectedFilterId: selectedFilterId,
                  onFilterSelected: (id) =>
                      context.read<TeacherHomeCubit>().selectFilter(id),
                ),
                SizedBox(height: bottomSpacing),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherHomeCubit, TeacherHomeState>(
      listener: (context, state) {
        state.maybeMap(
          success: (s) {
            if (s.actionError != null) {
              if (s.actionError == 'coming_soon') {
                AppSnackBar.showSuccess(
                  context,
                  context.l10n.postActionComingSoon,
                );
              } else {
                AppSnackBar.showError(context, s.actionError!);
              }
              context.read<TeacherHomeCubit>().clearActionError();
            }
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.map(
          initial: (_) => const TeacherHomeSkeletonView(),
          loading: (_) => const TeacherHomeSkeletonView(),
          error: (e) => TeacherHomeErrorView(
            message: e.message,
            onRetry: () => context.read<TeacherHomeCubit>().load(),
          ),
          empty: (e) => Scaffold(
            body: RefreshIndicator(
              onRefresh: () => context.read<TeacherHomeCubit>().refresh(),
              child: CustomScrollView(
                slivers: [
                  ..._buildHeaderSlivers(
                    context: context,
                    home: e.home,
                    selectedFilterId: e.selectedFilterId,
                    bottomSpacing: 24.h,
                  ),
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: TeacherHomeEmptyView()),
                  ),
                ],
              ),
            ),
          ),
          success: (s) => Scaffold(
            body: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.depth == 0 &&
                    scrollInfo is ScrollUpdateNotification) {
                  final metrics = scrollInfo.metrics;
                  if (metrics.pixels >= metrics.maxScrollExtent * 0.8) {
                    context.read<TeacherHomeCubit>().loadMore();
                  }
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: () => context.read<TeacherHomeCubit>().refresh(),
                child: CustomScrollView(
                  slivers: [
                    ..._buildHeaderSlivers(
                      context: context,
                      home: s.home,
                      selectedFilterId: s.selectedFilterId,
                      bottomSpacing: 12.h,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final post = s.posts[index];
                        return Center(
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 600.w),
                            child: TeacherWallPostCard(
                              post: post,
                              onLike: () => context
                                  .read<TeacherHomeCubit>()
                                  .toggleLike(post.id),
                              onEdit: () => context
                                  .read<TeacherHomeCubit>()
                                  .reportPost(post.id),
                              onDelete: () => context
                                  .read<TeacherHomeCubit>()
                                  .deletePost(post.id),
                              onPin: () => context
                                  .read<TeacherHomeCubit>()
                                  .pinPost(post.id),
                              onReport: () => context
                                  .read<TeacherHomeCubit>()
                                  .reportPost(post.id),
                              onModerate: () => context
                                  .read<TeacherHomeCubit>()
                                  .reportPost(post.id),
                              onCopyText: () => context
                                  .read<TeacherHomeCubit>()
                                  .copyPostText(post.id),
                            ),
                          ),
                        );
                      }, childCount: s.posts.length),
                    ),
                    if (s.isLoadingMore)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: 16.h,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    if (!s.hasMore && s.posts.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: 24.h,
                          ),
                          child: Center(
                            child: Text(
                              context.l10n.homeNoMorePosts,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
