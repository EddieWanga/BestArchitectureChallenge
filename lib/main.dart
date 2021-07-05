import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/sort_by.dart';
import 'package:best_architecture_challenge/features/fetch_posts/presentation/bloc/fetch_posts_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: BlocProvider(
        create: (_) =>
            di.sl<FetchPostsBloc>()..add(StartFetchPosts(sortBy: SortBy.id)),
        child: PostPage(title: 'FlutterTaipei :)'),
      ),
    );
  }
}

class PostPage extends StatelessWidget {
  PostPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('使用id排序'),
                        value: SortBy.id,
                      ),
                      PopupMenuItem(
                        child: Text('使用title排序'),
                        value: SortBy.title,
                      )
                    ],
                onSelected: (SortBy sortBy) {
                  BlocProvider.of<FetchPostsBloc>(context)
                      .add(StartFetchPosts(sortBy: sortBy));
                })
          ],
        ),
        body: BlocBuilder<FetchPostsBloc, FetchPostsState>(
            builder: (context, state) {
          if (state is FetchPostsLoaded) {
            final posts = state.posts;
            return ListView.separated(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
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
                      ));
                },
                separatorBuilder: (context, index) {
                  return Divider();
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }
}
