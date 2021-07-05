import 'package:best_architecture_challenge/core/failures.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/sort_by.dart';
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
    Post(id: 1, title: 'z title', body: 'any body'),
    Post(id: 2, title: 'a title', body: 'another body'),
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

      final result = await usecase(FetchPostsParams(sortBy: SortBy.id));

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

      final result = await usecase(FetchPostsParams(sortBy: SortBy.id));

      expect(result, emptyPost);
      verify(mockFetchPostsRepository.fetchPosts());
      verifyNoMoreInteractions(mockFetchPostsRepository);
    },
  );

  test(
    'FetchPosts sorted by id when success',
    () async {
      when(mockFetchPostsRepository.fetchPosts())
          .thenAnswer((_) async => Right(posts));

      final result = await usecase(FetchPostsParams(sortBy: SortBy.id));

      expect(result, Right(posts));
      verify(mockFetchPostsRepository.fetchPosts());
      verifyNoMoreInteractions(mockFetchPostsRepository);
    },
  );

  test(
    'FetchPosts sorted by title when success',
        () async {
      when(mockFetchPostsRepository.fetchPosts())
          .thenAnswer((_) async => Right(posts));

      final result = await usecase(FetchPostsParams(sortBy: SortBy.title));

      expect(result, Right(posts));
      verify(mockFetchPostsRepository.fetchPosts());
      verifyNoMoreInteractions(mockFetchPostsRepository);
    },
  );
}
