part of 'count_bloc.dart';

class CountState extends Equatable {
  const CountState();

  @override
  List<Object> get props => [];
}

class CountInitial extends CountState {}

class GetListCountPlanLoadingState extends CountState {
  const GetListCountPlanLoadingState();
  @override
  List<Object> get props => [];
}

class GetListCountPlanLoadedState extends CountState {
  const GetListCountPlanLoadedState(this.item);
  final List<CountPlanModel> item;

  @override
  List<Object> get props => [item];
}

class GetListCountPlanErrorState extends CountState {
  const GetListCountPlanErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

///All

class CheckAllLoadingState extends CountState {
  const CheckAllLoadingState();
  @override
  List<Object> get props => [];
}

class CheckAllLoadedState extends CountState {
  const CheckAllLoadedState(this.item);
  final ResponseModel item;

  @override
  List<Object> get props => [item];
}

class CheckAllErrorState extends CountState {
  const CheckAllErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

// UnCheck
class CheckUncheckLoadingState extends CountState {
  const CheckUncheckLoadingState();
  @override
  List<Object> get props => [];
}

class CheckUncheckLoadedState extends CountState {
  const CheckUncheckLoadedState(this.item);
  final ResponseModel item;

  @override
  List<Object> get props => [item];
}

class CheckUncheckErrorState extends CountState {
  const CheckUncheckErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

///Check Total
class CheckTotalLoadingState extends CountState {
  const CheckTotalLoadingState();
  @override
  List<Object> get props => [];
}

class CheckTotalLoadedState extends CountState {
  const CheckTotalLoadedState(this.item);
  final ResponseModel item;

  @override
  List<Object> get props => [item];
}

class CheckTotalErrorState extends CountState {
  const CheckTotalErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

///Get Location
class GetLocationLoadingState extends CountState {
  const GetLocationLoadingState();
  @override
  List<Object> get props => [];
}

class GetLocationLoadedState extends CountState {
  const GetLocationLoadedState(this.item);
  final List<LocationModel> item;

  @override
  List<Object> get props => [item];
}

class GetLocationErrorState extends CountState {
  const GetLocationErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

///Get Department
class GetDepartmentLoadingState extends CountState {
  const GetDepartmentLoadingState();
  @override
  List<Object> get props => [];
}

class GetDepartmentLoadedState extends CountState {
  const GetDepartmentLoadedState(this.item);
  final List<DepartmentModel> item;

  @override
  List<Object> get props => [item];
}

class GetDepartmentErrorState extends CountState {
  const GetDepartmentErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

///Get StatusAssets
class GetStatusAssetLoadingState extends CountState {
  const GetStatusAssetLoadingState();
  @override
  List<Object> get props => [];
}

class GetStatusAssetLoadedState extends CountState {
  const GetStatusAssetLoadedState(this.item);
  final List<StatusAssetCountModel> item;

  @override
  List<Object> get props => [item];
}

class GetStatusAssetErrorState extends CountState {
  const GetStatusAssetErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

///Get CountScanAssets List
class CountScanAssetsListLoadingState extends CountState {
  const CountScanAssetsListLoadingState();
  @override
  List<Object> get props => [];
}

class CountScanAssetsListLoadedState extends CountState {
  const CountScanAssetsListLoadedState(this.item);
  final CountScanMain item;

  @override
  List<Object> get props => [item];
}

class CountScanAssetsListErrorState extends CountState {
  const CountScanAssetsListErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

///Get CountScanAssets
class CountScanSaveAssetsLoadingState extends CountState {
  const CountScanSaveAssetsLoadingState();
  @override
  List<Object> get props => [];
}

class CountScanSaveAssetsLoadedState extends CountState {
  const CountScanSaveAssetsLoadedState(this.item);
  final CountScanMain item;

  @override
  List<Object> get props => [item];
}

class CountScanSaveAssetsErrorState extends CountState {
  const CountScanSaveAssetsErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

///Get GetListImageAsset
class GetListImageAssetLoadingState extends CountState {
  const GetListImageAssetLoadingState();
  @override
  List<Object> get props => [];
}

class GetListImageAssetLoadedState extends CountState {
  const GetListImageAssetLoadedState(this.item);
  final List<ListImageAssetModel> item;

  @override
  List<Object> get props => [item];
}

class GetListImageAssetErrorState extends CountState {
  const GetListImageAssetErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

///POST UploadImage
class UploadImageLoadingState extends CountState {
  const UploadImageLoadingState();
  @override
  List<Object> get props => [];
}

class UploadImageLoadedState extends CountState {
  const UploadImageLoadedState(this.item);
  final CountScanMain item;

  @override
  List<Object> get props => [item];
}

class UploadImageErrorState extends CountState {
  const UploadImageErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
