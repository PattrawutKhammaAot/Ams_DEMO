part of 'assets_bloc.dart';

class AssetsState extends Equatable {
  const AssetsState();

  @override
  List<Object> get props => [];
}

class AssetsInitial extends AssetsState {}

class GetDashBoardAssetStatusLoadingState extends AssetsState {
  const GetDashBoardAssetStatusLoadingState();
  @override
  List<Object> get props => [];
}

class GetDashBoardAssetStatusLoadedState extends AssetsState {
  const GetDashBoardAssetStatusLoadedState(this.item);
  final DashBoardAssetStatusModel item;

  @override
  List<Object> get props => [item];
}

class GetDashBoardAssetStatusErrorState extends AssetsState {
  const GetDashBoardAssetStatusErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

class GetDetailAssetLoadingState extends AssetsState {
  const GetDetailAssetLoadingState();
  @override
  List<Object> get props => [];
}

class GetDetailAssetLoadedState extends AssetsState {
  const GetDetailAssetLoadedState(this.item);
  final GetDetailAssetModel item;

  @override
  List<Object> get props => [item];
}

class GetDetailAssetErrorState extends AssetsState {
  const GetDetailAssetErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
