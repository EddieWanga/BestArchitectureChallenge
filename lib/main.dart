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
        create: (_) => di.sl<FetchPostsBloc>()..add(StartFetchPosts()),
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
                      .add(StartFetchPosts());
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
                  String id = posts[index].id;
                  String title = posts[index].title;
                  String body = posts[index].body;
                  return Container(
                      padding: EdgeInsets.all(8),
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: "$id. $title",
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                            TextSpan(
                              text: '\n' + body,
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

// void _fetchData(int sort) async {
//   var url = Uri.https('jsonplaceholder.typicode.com', '/posts');
//   var response = await http.get(url);
//   print("response=${response.body}");
//   List<dynamic> result = jsonDecode(response.body);
//   if (sort == _sortWithId) {
//     result.sort((a, b) {
//       return int.parse(a['id'].toString())
//           .compareTo(int.parse(b['id'].toString()));
//     });
//   } else if (sort == _sortWithTitle) {
//     result.sort((a, b) {
//       return a['title'].toString().compareTo(b['title'].toString());
//     });
//   }
//   setState(() {
//     _posts = result;
//   });
// }
}
