import 'package:best_architecture_challenge/core/failures.dart';
import 'package:best_architecture_challenge/core/usecase.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/sort_by.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/repositories/fetch_posts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchPosts
    implements UseCase<List<Post>, FetchPostsParams> {
  final FetchPostsRepository repository;

  FetchPosts(this.repository);

  @override
  Future<Either<Failure, List<Post>>> call(FetchPostsParams params) async {
    final result = await repository.fetchPosts();

    return result.fold((failure) => Left(failure), (posts) {
      if (params.sortBy == SortBy.id) {
        posts.sort((a, b) => a.id.compareTo(b.id));
      } else if (params.sortBy == SortBy.title) {
        posts.sort((a, b) => a.title.compareTo(b.title));
      }
      return Right(posts);
    });
  }
}

class FetchPostsParams extends Equatable {
  final SortBy sortBy;

  FetchPostsParams({required this.sortBy});

  @override
  List<Object?> get props => [sortBy];
}