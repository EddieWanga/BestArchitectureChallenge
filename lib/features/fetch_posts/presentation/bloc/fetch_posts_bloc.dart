import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'fetch_posts_event.dart';
part 'fetch_posts_state.dart';
class FetchPostsBloc extends Bloc<FetchPostsEvent, FetchPostsState> {
  FetchPostsBloc() : super(FetchDataInitial());
  @override
  Stream<FetchPostsState> mapEventToState(
    FetchPostsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
