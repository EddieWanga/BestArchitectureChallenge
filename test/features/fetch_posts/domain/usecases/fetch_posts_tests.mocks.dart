// Mocks generated by Mockito 5.0.10 from annotations
// in best_architecture_challenge/test/features/fetch_posts/domain/usecases/fetch_posts_tests.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:best_architecture_challenge/core/failures.dart' as _i5;
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart'
    as _i6;
import 'package:best_architecture_challenge/features/fetch_posts/domain/repositories/fetch_posts_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {
  @override
  String toString() => super.toString();
}

/// A class which mocks [FetchPostsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchPostsRepository extends _i1.Mock
    implements _i3.FetchPostsRepository {
  MockFetchPostsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Post>>> fetchPosts() =>
      (super.noSuchMethod(Invocation.method(#fetchPosts, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Post>>>.value(
              _FakeEither<_i5.Failure, List<_i6.Post>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Post>>>);
}
