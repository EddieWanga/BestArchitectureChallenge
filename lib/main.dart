import 'package:best_architecture_challenge/features/fetch_posts/domain/entities/post.dart';
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
        create: (_) => di.sl<FetchPostsBloc>()..add(StartFetchPosts(sort: 1)),
        child: PostPage(title: 'FlutterTaipei :)'),
      ),
    );
  }
}

class PostPage extends StatelessWidget {
  PostPage({Key? key, required this.title}) : super(key: key);
  static const int _sortWithId = 1;
  static const int _sortWithTitle = 2;

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
                        value: _sortWithId,
                      ),
                      PopupMenuItem(
                        child: Text('使用title排序'),
                        value: _sortWithTitle,
                      )
                    ],
                onSelected: (int value) {
                  BlocProvider.of<FetchPostsBloc>(context)
                      .add(StartFetchPosts(sort: value));
                })
          ],
        ),
        body: BlocBuilder<FetchPostsBloc, FetchPostsState>(
            builder: (context, state) {
          if (state is FetchPostsLoaded) {
            final posts = state.posts;
            postsSorted(posts, state.sort);
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

  void postsSorted(List<Post> posts, int sort) {
    if (sort == _sortWithId) {
      posts.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
    } else if (sort == _sortWithTitle) {
      posts.sort((a, b) => a.title.compareTo(b.title));
    }
  }
}
