import 'package:best_architecture_challenge/core/failures.dart';
import 'package:best_architecture_challenge/core/usecase.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/repositories/fetch_posts_repository.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/usecases/fetch_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/shared_helpers.dart';
import 'fetch_posts_test.mocks.dart';

@GenerateMocks([FetchPostsRepository])
void main() async {
  final posts = [
    Post(id: 'any id', title: 'any title', body: 'any body'),
    Post(id: 'another id', title: 'another title', body: 'another body'),
  ];

  final emptyPost = Right<Failure, List<Post>>([]);

  late FetchPosts usecase;
  late MockFetchPostsRepository mockFetchPostsRepository;
  setUp(() {
    mockFetchPostsRepository = MockFetchPostsRepository();
    usecase = FetchPosts(mockFetchPostsRepository);
  });

  test(
    'FetchPosts when failure',
        () async {
      when(mockFetchPostsRepository.fetchPosts())
          .thenAnswer((_) async => Left(anyFailure));

      final result = await usecase(NoParams());

      expect(result, Left(anyFailure));
      verify(mockFetchPostsRepository.fetchPosts());
      verifyNoMoreInteractions(mockFetchPostsRepository);
    },
  );

  test(
    'FetchPosts when empty',
        () async {
      when(mockFetchPostsRepository.fetchPosts())
          .thenAnswer((_) async => emptyPost);

      final result = await usecase(NoParams());

      expect(result, emptyPost);
      verify(mockFetchPostsRepository.fetchPosts());
      verifyNoMoreInteractions(mockFetchPostsRepository);
    },
  );

  test(
    'FetchPosts when success',
        () async {
      when(mockFetchPostsRepository.fetchPosts())
          .thenAnswer((_) async => Right(posts));

      final result = await usecase(NoParams());

      expect(result, Right(posts));
      verify(mockFetchPostsRepository.fetchPosts());
      verifyNoMoreInteractions(mockFetchPostsRepository);
    },
  );
}