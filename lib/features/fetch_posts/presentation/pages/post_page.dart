import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/sort_by.dart';
import 'package:best_architecture_challenge/features/fetch_posts/presentation/bloc/fetch_posts_bloc.dart';
import 'package:best_architecture_challenge/features/fetch_posts/presentation/widgets/post_view.dart';
import 'package:best_architecture_challenge/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatelessWidget {
  final String title;

  PostPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<FetchPostsBloc>()..add(StartFetchPosts(sortBy: SortBy.id)),
      child: PostView(title: 'FlutterTaipei :)'),
    );
  }
}
