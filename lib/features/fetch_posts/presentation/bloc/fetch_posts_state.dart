part of 'fetch_posts_bloc.dart';
abstract class FetchPostsState extends Equatable {
  const FetchPostsState();
}
class FetchDataInitial extends FetchPostsState {
  @override
  List<Object> get props => [];
}
