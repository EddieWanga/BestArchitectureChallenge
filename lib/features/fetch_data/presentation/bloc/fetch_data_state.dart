part of 'fetch_data_bloc.dart';
abstract class FetchDataState extends Equatable {
  const FetchDataState();
}
class FetchDataInitial extends FetchDataState {
  @override
  List<Object> get props => [];
}
