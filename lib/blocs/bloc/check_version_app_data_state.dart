part of 'check_version_app_data_bloc.dart';

class CheckVersionAppDataState extends Equatable {
  const CheckVersionAppDataState();

  @override
  List<Object> get props => [];
}

class CheckVersionAppDataInitial extends CheckVersionAppDataState {}

class CheckVersionLoadingState extends CheckVersionAppDataState {
  const CheckVersionLoadingState();
  @override
  List<Object> get props => [];
}

class CheckVersionLoadedState extends CheckVersionAppDataState {
  const CheckVersionLoadedState(this.item);

  final CheckVersionModel item;

  @override
  List<Object> get props => [item];
}

class CheckVersionErrorState extends CheckVersionAppDataState {
  const CheckVersionErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
