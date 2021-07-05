import 'package:best_architecture_challenge/core/failures.dart';
import 'package:best_architecture_challenge/features/fetch_posts/data/datasources/fetch_posts_remote_data_source.dart';
import 'package:best_architecture_challenge/features/fetch_posts/data/models/post_model.dart';
import 'package:best_architecture_challenge/features/fetch_posts/data/repositories/fetch_posts_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../../helpers/shared_helpers.dart';
import 'fetch_posts_repository_impl_test.mocks.dart';

@GenerateMocks([FetchPostsRemoteDataSource])
void main() async {
  final posts = [
    PostModel(id: 1, title: 'z title', body: 'any body'),
    PostModel(id: 2, title: 'a title', body: 'another body'),
  ];

  final emptyPost = <PostModel>[];

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
      when(mockRemoteDataSource.fetchPosts()).thenThrow(anyException);

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
      when(mockRemoteDataSource.fetchPosts()).thenAnswer((_) async => posts);

      final result = await repository.fetchPosts();

      expect(result, Right(posts));
    },
  );
}
