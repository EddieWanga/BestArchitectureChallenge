import 'package:best_architecture_challenge/core/usecase.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/usecases/fetch_posts.dart';
import 'package:best_architecture_challenge/features/fetch_posts/presentation/bloc/fetch_posts_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/shared_helpers.dart';
import 'fetch_posts_bloc_test.mocks.dart';

@GenerateMocks([FetchPosts])
void main() async {
  final posts = [
    Post(id: 'any id', title: 'any title', body: 'any body'),
    Post(id: 'another id', title: 'another title', body: 'another body'),
  ];

  final empty = <Post>[];

  late FetchPostsBloc bloc;
  late MockFetchPosts mockFetchPosts;

  setUp(() {
    mockFetchPosts = MockFetchPosts();

    bloc = FetchPostsBloc(fetchPosts: mockFetchPosts);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is correct', () {
    expect(bloc.state, FetchPostsInitial());
  });

  test('close does not emit new states', () {
    expectLater(bloc.stream, emitsInOrder([emitsDone]));
    bloc.close();
  });

  blocTest<FetchPostsBloc, FetchPostsState>(
    'FetchPosts emits [Loading, Error] when failure',
    build: () {
      when(mockFetchPosts(NoParams()))
          .thenAnswer((_) async => Left(anyFailure));
      return bloc;
    },
    act: (bloc) => bloc.add(StartFetchPosts()),
    expect: () => [FetchPostsLoading(), FetchPostsError(anyFailure)],
  );

  blocTest<FetchPostsBloc, FetchPostsState>(
    'FetchPosts emits [Loading, Loaded] when empty',
    build: () {
      when(mockFetchPosts(NoParams())).thenAnswer((_) async => Right(empty));
      return bloc;
    },
    act: (bloc) => bloc.add(StartFetchPosts()),
    expect: () => [FetchPostsLoading(), FetchPostsLoaded(empty)],
  );

  blocTest<FetchPostsBloc, FetchPostsState>(
    'FetchPosts emits [Loading, Loaded] when load data success',
    build: () {
      when(mockFetchPosts(NoParams())).thenAnswer((_) async => Right(posts));
      return bloc;
    },
    act: (bloc) => bloc.add(StartFetchPosts()),
    expect: () => [FetchPostsLoading(), FetchPostsLoaded(posts)],
  );
}
