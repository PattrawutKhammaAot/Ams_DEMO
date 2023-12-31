part of 'assets_bloc.dart';

class AssetsEvent extends Equatable {
  const AssetsEvent();

  @override
  List<Object> get props => [];
}

class AssetsObserve extends AssetsEvent {}

class GetDashBoardAssetStatusEvent extends AssetsEvent {
  const GetDashBoardAssetStatusEvent();

  @override
  List<Object> get prop => [];
}

class GetDetailAssetEvent extends AssetsEvent {
  const GetDetailAssetEvent(this.assetCode);

  final String assetCode;

  @override
  List<Object> get prop => [assetCode];
}
