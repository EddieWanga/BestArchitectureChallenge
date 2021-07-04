import 'dart:convert';
import 'package:best_architecture_challenge/features/fetch_posts/data/datasources/fetch_posts_remote_data_source.dart';
import 'package:best_architecture_challenge/features/fetch_posts/data/models/post_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';
import 'fetch_posts_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final url = Uri.https('jsonplaceholder.typicode.com', '/posts');

  late FetchPostsRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = FetchPostsRemoteDataSourceImpl(client: mockClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('posts.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('fetch posts', () {
    List<dynamic> result = json.decode(fixture('posts.json'));
    final models = result.map((e) => PostModel.fromJson(e)).toList();

    test(
      'should perform a GET request on a URL',
          () async {
        setUpMockHttpClientSuccess200();

        dataSource.fetchPosts();

        verify(mockClient.get(url));
      },
    );

    test(
      'should return PostModels when the response code is 200 (success)',
          () async {

        setUpMockHttpClientSuccess200();

        final result = await dataSource.fetchPosts();

        expect(result, equals(models));
      },
    );

    test(
      'should throw a Exception when the response code is 404 or other',
          () async {
        setUpMockHttpClientFailure404();

        final call = dataSource.fetchPosts;

        expect(() => call(), throwsA(TypeMatcher<Exception>()));
      },
    );
  });
}