import 'dart:convert';

import 'package:best_architecture_challenge/features/fetch_posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class FetchPostsRemoteDataSource {
  Future<List<PostModel>> fetchPosts();
}

class FetchPostsRemoteDataSourceImpl extends FetchPostsRemoteDataSource {
  final http.Client client;

  FetchPostsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> fetchPosts() async {
    var url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    var response = await client.get(url);
    print("response=${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> result = json.decode(response.body);
      return result.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception('statusCode not equal to 200');
    }
  }
}
