import 'package:best_architecture_challenge/core/failures.dart';
import 'package:best_architecture_challenge/features/fetch_posts/data/datasources/fetch_posts_remote_data_source.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/repositories/fetch_posts_repository.dart';
import 'package:dartz/dartz.dart';

class FetchPostsRepositoryImpl extends FetchPostsRepository {
  final FetchPostsRemoteDataSource remoteDataSource;

  FetchPostsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Post>>> fetchPosts() async {
    try {
      final posts = await remoteDataSource.fetchPosts();
      return Right(posts);
    } catch (e) {
      return Left(ServiceFailure(e));
    }
  }
}