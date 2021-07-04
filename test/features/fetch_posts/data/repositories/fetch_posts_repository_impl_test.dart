import 'package:best_architecture_challenge/core/failures.dart';
import 'package:best_architecture_challenge/features/fetch_posts/data/datasources/fetch_posts_remote_data_source.dart';
import 'package:best_architecture_challenge/features/fetch_posts/data/repositories/fetch_posts_repository_impl.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/shared_helpers.dart';
import 'fetch_posts_repository_impl_test.mocks.dart';

@GenerateMocks([FetchPostsRemoteDataSource])
void main() async {
  final posts = [
    Post(id: 'any id', title: 'any title', body: 'any body'),
    Post(id: 'another id', title: 'another title', body: 'another body'),
  ];

  final emptyPost = <Post>[];

  late FetchPostsRepositoryImpl repository;
  late MockFetchPostsRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockFetchPostsRemoteDataSource();
    repository = FetchPostsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  test(
    'FetchPosts when failure',
        () async {
      when(mockRemoteDataSource.fetchPosts())
          .thenThrow(anyException);

      final result = await repository.fetchPosts();

      expect(result, Left(ServiceFailure(anyException)));
    },
  );

  test(
    'FetchPosts when empty',
        () async {
      when(mockRemoteDataSource.fetchPosts())
          .thenAnswer((_) async => emptyPost);

      final result = await repository.fetchPosts();

      expect(result, Right(emptyPost));
    },
  );

  test(
    'FetchPosts when success',
        () async {
      when(mockRemoteDataSource.fetchPosts())
          .thenAnswer((_) async => posts);

      final result = await repository.fetchPosts();

      expect(result, Right(posts));
    },
  );
}