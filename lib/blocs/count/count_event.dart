// ignore_for_file: must_be_immutable

part of 'count_bloc.dart';

class CountEvent extends Equatable {
  const CountEvent();

  @override
  List<Object> get props => [];
}

class CountObserve extends CountEvent {}

class GetListCountPlanEvent extends CountEvent {
  const GetListCountPlanEvent();

  @override
  List<Object> get prop => [];
}

class CheckAllTotalEvent extends CountEvent {
  const CheckAllTotalEvent();

  @override
  List<Object> get prop => [];
}

class CheckTotalEvent extends CountEvent {
  const CheckTotalEvent();

  @override
  List<Object> get prop => [];
}

class CheckUncheckEvent extends CountEvent {
  const CheckUncheckEvent();

  @override
  List<Object> get prop => [];
}

class CheckCountOpenCloseTotal extends CountEvent {
  const CheckCountOpenCloseTotal();

  @override
  List<Object> get prop => [];
}

class GetLocationEvent extends CountEvent {
  const GetLocationEvent();

  @override
  List<Object> get prop => [];
}

class GetDepartmentEvent extends CountEvent {
  const GetDepartmentEvent();

  @override
  List<Object> get prop => [];
}

class GetStatusAssetsCountEvent extends CountEvent {
  const GetStatusAssetsCountEvent();

  @override
  List<Object> get prop => [];
}

class PostCountScanAssetListEvent extends CountEvent {
  PostCountScanAssetListEvent(this.items);
  List<CountScan_OutputModel> items;
  @override
  List<Object> get prop => [items];
}

class PostCountScanAssetEvent extends CountEvent {
  PostCountScanAssetEvent(this.items);
  CountScan_OutputModel items;
  @override
  List<Object> get prop => [items];
}

class GetListImageAssetsEvent extends CountEvent {
  GetListImageAssetsEvent(this.items);
  String items;
  @override
  List<Object> get prop => [items];
}

class UploadImageEvent extends CountEvent {
  UploadImageEvent(this.items);
  UploadImageModelOutput items;
  @override
  List<Object> get prop => [items];
}
