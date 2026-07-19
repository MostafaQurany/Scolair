import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/teacher_home.dart';
import '../../domain/entities/teacher_wall_post.dart';
import '../../domain/usecases/get_teacher_home_usecase.dart';
import '../../domain/usecases/get_wall_posts_usecase.dart';
import '../../domain/usecases/toggle_wall_post_like_usecase.dart';
import 'home_state.dart';

class TeacherHomeCubit extends Cubit<TeacherHomeState> {
  TeacherHomeCubit(
    this._getTeacherHomeUseCase,
    this._getWallPostsUseCase,
    this._toggleWallPostLikeUseCase,
  ) : super(const TeacherHomeState.initial());

  final GetTeacherHomeUseCase _getTeacherHomeUseCase;
  final GetWallPostsUseCase _getWallPostsUseCase;
  final ToggleWallPostLikeUseCase _toggleWallPostLikeUseCase;

  int _currentPage = 1;
  static const int _pageSize = 4;

  Future<void> load() async {
    emit(const TeacherHomeState.loading());
    _currentPage = 1;

    final homeResult = await _getTeacherHomeUseCase();
    await homeResult.when(
      success: (home) async {
        final defaultFilterId = home.filters.firstOrNull?.id ?? 'all';
        final postsResult = await _getWallPostsUseCase(
          filterId: defaultFilterId,
          page: _currentPage,
          pageSize: _pageSize,
        );

        postsResult.when(
          success: (pageData) {
            if (pageData.posts.isEmpty) {
              emit(
                TeacherHomeState.empty(
                  home: home,
                  selectedFilterId: defaultFilterId,
                ),
              );
            } else {
              emit(
                TeacherHomeState.success(
                  home: home,
                  posts: pageData.posts,
                  selectedFilterId: defaultFilterId,
                  hasMore: pageData.hasMore,
                  isLoadingMore: false,
                  isRefreshing: false,
                ),
              );
            }
          },
          failure: (failure) {
            emit(TeacherHomeState.error(message: failure.message));
          },
        );
      },
      failure: (failure) {
        emit(TeacherHomeState.error(message: failure.message));
      },
    );
  }

  Future<void> refresh() async {
    final currentState = state;
    if (currentState is! TeacherHomeSuccess &&
        currentState is! TeacherHomeEmpty) {
      await load();
      return;
    }

    if (currentState is TeacherHomeSuccess) {
      emit(currentState.copyWith(isRefreshing: true, actionError: null));
    }

    _currentPage = 1;

    final homeResult = await _getTeacherHomeUseCase();
    await homeResult.when(
      success: (home) async {
        final currentFilterId = currentState is TeacherHomeSuccess
            ? currentState.selectedFilterId
            : (currentState as TeacherHomeEmpty).selectedFilterId;

        final postsResult = await _getWallPostsUseCase(
          filterId: currentFilterId,
          page: _currentPage,
          pageSize: _pageSize,
        );

        postsResult.when(
          success: (pageData) {
            if (pageData.posts.isEmpty) {
              emit(
                TeacherHomeState.empty(
                  home: home,
                  selectedFilterId: currentFilterId,
                ),
              );
            } else {
              emit(
                TeacherHomeState.success(
                  home: home,
                  posts: pageData.posts,
                  selectedFilterId: currentFilterId,
                  hasMore: pageData.hasMore,
                  isLoadingMore: false,
                  isRefreshing: false,
                ),
              );
            }
          },
          failure: (failure) {
            if (currentState is TeacherHomeSuccess) {
              emit(
                currentState.copyWith(
                  isRefreshing: false,
                  actionError: failure.message,
                ),
              );
            } else {
              emit(TeacherHomeState.error(message: failure.message));
            }
          },
        );
      },
      failure: (failure) {
        if (currentState is TeacherHomeSuccess) {
          emit(
            currentState.copyWith(
              isRefreshing: false,
              actionError: failure.message,
            ),
          );
        } else {
          emit(TeacherHomeState.error(message: failure.message));
        }
      },
    );
  }

  Future<void> selectFilter(String filterId) async {
    final currentState = state;
    TeacherHome? home;

    if (currentState is TeacherHomeSuccess) {
      if (currentState.selectedFilterId == filterId) {
        return;
      }
      home = currentState.home;
    } else if (currentState is TeacherHomeEmpty) {
      if (currentState.selectedFilterId == filterId) {
        return;
      }
      home = currentState.home;
    }

    final safeHome = home;
    if (safeHome == null) return;

    emit(const TeacherHomeState.loading());
    _currentPage = 1;

    final postsResult = await _getWallPostsUseCase(
      filterId: filterId,
      page: _currentPage,
      pageSize: _pageSize,
    );

    postsResult.when(
      success: (pageData) {
        if (pageData.posts.isEmpty) {
          emit(
            TeacherHomeState.empty(home: safeHome, selectedFilterId: filterId),
          );
        } else {
          emit(
            TeacherHomeState.success(
              home: safeHome,
              posts: pageData.posts,
              selectedFilterId: filterId,
              hasMore: pageData.hasMore,
              isLoadingMore: false,
              isRefreshing: false,
            ),
          );
        }
      },
      failure: (failure) {
        emit(TeacherHomeState.error(message: failure.message));
      },
    );
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! TeacherHomeSuccess ||
        !currentState.hasMore ||
        currentState.isLoadingMore ||
        currentState.isRefreshing) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true, actionError: null));

    final nextPage = _currentPage + 1;
    final postsResult = await _getWallPostsUseCase(
      filterId: currentState.selectedFilterId,
      page: nextPage,
      pageSize: _pageSize,
    );

    postsResult.when(
      success: (pageData) {
        _currentPage = nextPage;

        final mergedPosts = List<TeacherWallPost>.from(currentState.posts);
        final existingIds = mergedPosts.map((p) => p.id).toSet();
        for (final post in pageData.posts) {
          if (!existingIds.contains(post.id)) {
            mergedPosts.add(post);
            existingIds.add(post.id);
          }
        }

        emit(
          currentState.copyWith(
            posts: mergedPosts,
            hasMore: pageData.hasMore,
            isLoadingMore: false,
          ),
        );
      },
      failure: (failure) {
        emit(
          currentState.copyWith(
            isLoadingMore: false,
            actionError: failure.message,
          ),
        );
      },
    );
  }

  Future<void> toggleLike(String postId) async {
    final currentState = state;
    if (currentState is! TeacherHomeSuccess) return;

    final index = currentState.posts.indexWhere((p) => p.id == postId);
    if (index == -1) return;

    final originalPost = currentState.posts[index];
    final shouldLike = !originalPost.isLikedByCurrentUser;

    final updatedPost = originalPost.copyWith(
      isLikedByCurrentUser: shouldLike,
      likeCount: shouldLike
          ? originalPost.likeCount + 1
          : originalPost.likeCount - 1,
    );

    final updatedPosts = List<TeacherWallPost>.from(currentState.posts);
    updatedPosts[index] = updatedPost;

    emit(currentState.copyWith(posts: updatedPosts, actionError: null));

    final result = await _toggleWallPostLikeUseCase(
      postId: postId,
      shouldLike: shouldLike,
    );

    result.when(
      success: (serverPost) {
        final syncPosts = List<TeacherWallPost>.from(
          state.maybeMap(success: (s) => s.posts, orElse: () => updatedPosts),
        );
        final syncIndex = syncPosts.indexWhere((p) => p.id == postId);
        if (syncIndex != -1) {
          syncPosts[syncIndex] = serverPost;
          emit((state as TeacherHomeSuccess).copyWith(posts: syncPosts));
        }
      },
      failure: (failure) {
        final rollbackPosts = List<TeacherWallPost>.from(
          state.maybeMap(success: (s) => s.posts, orElse: () => updatedPosts),
        );
        final rollbackIndex = rollbackPosts.indexWhere((p) => p.id == postId);
        if (rollbackIndex != -1) {
          rollbackPosts[rollbackIndex] = originalPost;
          emit(
            (state as TeacherHomeSuccess).copyWith(
              posts: rollbackPosts,
              actionError: failure.message,
            ),
          );
        }
      },
    );
  }

  void clearActionError() {
    final currentState = state;
    if (currentState is TeacherHomeSuccess) {
      if (currentState.actionError != null) {
        emit(currentState.copyWith(actionError: null));
      }
    }
  }

  Future<void> reportPost(String postId) async {
    _triggerComingSoon();
  }

  Future<void> copyPostText(String postId) async {
    _triggerComingSoon();
  }

  Future<void> pinPost(String postId) async {
    _triggerComingSoon();
  }

  Future<void> deletePost(String postId) async {
    _triggerComingSoon();
  }

  void _triggerComingSoon() {
    final currentState = state;
    if (currentState is TeacherHomeSuccess) {
      emit(currentState.copyWith(actionError: 'coming_soon'));
    }
  }
}
