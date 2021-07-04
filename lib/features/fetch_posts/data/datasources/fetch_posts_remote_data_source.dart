import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';

abstract class FetchPostsRemoteDataSource {
  Future<List<Post>> fetchPosts();
}