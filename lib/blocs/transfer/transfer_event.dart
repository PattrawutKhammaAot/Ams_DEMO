part of 'transfer_bloc.dart';

class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object> get props => [];
}

class TransferObserve extends TransferEvent {}

class TF_CompanyEvent extends TransferEvent {
  const TF_CompanyEvent();

  @override
  List<Object> get prop => [];
}

// class TF_LocationEvent extends TransferEvent {
//   const TF_LocationEvent();

//   @override
//   List<Object> get prop => [];
// }

class TF_BranchEvent extends TransferEvent {
  const TF_BranchEvent();

  @override
  List<Object> get prop => [];
}

class TF_BuildingEvent extends TransferEvent {
  const TF_BuildingEvent();

  @override
  List<Object> get prop => [];
}

class TF_RoomEvent extends TransferEvent {
  const TF_RoomEvent();

  @override
  List<Object> get prop => [];
}

// class TF_DepartmentEvent extends TransferEvent {
//   const TF_DepartmentEvent();

//   @override
//   List<Object> get prop => [];
// }

class TF_OwnerEvent extends TransferEvent {
  const TF_OwnerEvent();

  @override
  List<Object> get prop => [];
}

class TF_transferAsset extends TransferEvent {
  TF_transferAsset(this.output);

  TransferAssetOutputModel output;

  @override
  List<Object> get prop => [output];
}
