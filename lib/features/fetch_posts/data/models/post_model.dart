import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required String id,
    required String title,
    required String body,
  }) : super(id: id, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'].toString(),
      title: json['title'].toString(),
      body: json['body'].toString(),
    );
  }
}