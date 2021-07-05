import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/sort_by.dart';
import 'package:best_architecture_challenge/features/fetch_posts/presentation/bloc/fetch_posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostView extends StatelessWidget {
  final String title;

  PostView({required this.title});

  @override
  Widget build(BuildContext context) {
    AppBar buildAppBar(String title) {
      return AppBar(
        title: Text(title),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('使用 id 排序'),
                      value: SortBy.id,
                    ),
                    PopupMenuItem(
                      child: Text('使用 title 排序'),
                      value: SortBy.title,
                    )
                  ],
              onSelected: (SortBy sortBy) {
                BlocProvider.of<FetchPostsBloc>(context)
                    .add(StartFetchPosts(sortBy: sortBy));
              })
        ],
      );
    }

    Container buildListViewItem(BuildContext context, Post post) {
      return Container(
        padding: EdgeInsets.all(8),
        child: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: "${post.id}. ${post.title}",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
              TextSpan(
                text: '\n' + post.body,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    ListView buildListView(List<Post> posts) {
      return ListView.separated(
          itemCount: posts.length,
          itemBuilder: (context, index) =>
              buildListViewItem(context, posts[index]),
          separatorBuilder: (context, index) => Divider());
    }

    return Scaffold(
      appBar: buildAppBar(title),
      body: BlocBuilder<FetchPostsBloc, FetchPostsState>(
          builder: (context, state) {
        if (state is FetchPostsLoaded) {
          return buildListView(state.posts);
        } else if (state is FetchPostsLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      }),
    );
  }
}
