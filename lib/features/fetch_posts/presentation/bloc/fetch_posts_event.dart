part of 'fetch_posts_bloc.dart';

abstract class FetchPostsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartFetchPosts extends FetchPostsEvent {}
