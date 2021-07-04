import 'package:best_architecture_challenge/core/failures.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class FetchPostsRepository {
  Future<Either<Failure, List<Post>>> fetchPosts();
}