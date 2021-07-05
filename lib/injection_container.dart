import 'package:best_architecture_challenge/features/fetch_posts/data/datasources/fetch_posts_remote_data_source.dart';
import 'package:best_architecture_challenge/features/fetch_posts/data/repositories/fetch_posts_repository_impl.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/repositories/fetch_posts_repository.dart';
import 'package:best_architecture_challenge/features/fetch_posts/domain/usecases/fetch_posts.dart';
import 'package:best_architecture_challenge/features/fetch_posts/presentation/bloc/fetch_posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Fetch Posts
  // Bloc
  sl.registerFactory(
    () => FetchPostsBloc(
      fetchPosts: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => FetchPosts(sl()));

  // Repository
  sl.registerLazySingleton<FetchPostsRepository>(
    () => FetchPostsRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<FetchPostsRemoteDataSource>(
    () => FetchPostsRemoteDataSourceImpl(client: sl()),
  );

  //! External
  sl.registerLazySingleton(() => http.Client());
}
