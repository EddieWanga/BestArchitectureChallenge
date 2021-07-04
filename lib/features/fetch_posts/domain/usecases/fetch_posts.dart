import 'package:best_architecture_challenge/core/failures.dart';
import 'package:best_architecture_challenge/core/usecase.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/repositories/fetch_posts_repository.dart';
import 'package:dartz/dartz.dart';

class FetchPosts
    implements UseCase<List<Post>, NoParams> {
  final FetchPostsRepository repository;

  FetchPosts(this.repository);

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) async =>
      await repository.fetchPosts();
}