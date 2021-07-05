part of 'fetch_posts_bloc.dart';

abstract class FetchPostsState extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPostsInitial extends FetchPostsState {}

class FetchPostsLoading extends FetchPostsState {}

class FetchPostsLoaded extends FetchPostsState {
  final List<Post> posts;

  FetchPostsLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

class FetchPostsError extends FetchPostsState {
  final Failure failure;

  FetchPostsError(this.failure);

  @override
  List<Object> get props => [failure];
}
