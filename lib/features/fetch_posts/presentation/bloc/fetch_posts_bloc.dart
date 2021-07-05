import 'dart:async';

import 'package:best_architecture_challenge/core/failures.dart';
import 'package:best_architecture_challenge/core/usecase.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/usecases/fetch_posts.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_posts_event.dart';

part 'fetch_posts_state.dart';

class FetchPostsBloc extends Bloc<FetchPostsEvent, FetchPostsState> {
  final FetchPosts fetchPosts;

  FetchPostsBloc({required this.fetchPosts}) : super(FetchPostsInitial());

  @override
  Stream<FetchPostsState> mapEventToState(
    FetchPostsEvent event,
  ) async* {
    if (event is StartFetchPosts) {
      yield FetchPostsLoading();
      final result = await fetchPosts(NoParams());
      yield result.fold((failure) => FetchPostsError(failure),
          (posts) => FetchPostsLoaded(sort: event.sort, posts: posts));
    }
  }
}
