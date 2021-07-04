import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  @override
  List<Object> get props => [id, title, body];
}