part of 'transfer_bloc.dart';

class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object> get props => [];
}

class TransferInitial extends TransferState {}

///
class TF_CompanyLoadingState extends TransferState {
  const TF_CompanyLoadingState();
  @override
  List<Object> get props => [];
}

class TF_CompanyLoadedState extends TransferState {
  TF_CompanyLoadedState(this.item);
  List<SelectDestinationDropdownModel> item;
  @override
  List<Object> get props => [item];
}

class TF_CompanyErrorState extends TransferState {
  const TF_CompanyErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
////

class TF_BranchLoadingState extends TransferState {
  const TF_BranchLoadingState();
  @override
  List<Object> get props => [];
}

class TF_BranchLoadedState extends TransferState {
  TF_BranchLoadedState(this.item);
  List<SelectDestinationDropdownModel> item;
  @override
  List<Object> get props => [item];
}

class TF_BranchErrorState extends TransferState {
  const TF_BranchErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

// Building
class TF_BuildingLoadingState extends TransferState {
  const TF_BuildingLoadingState();
  @override
  List<Object> get props => [];
}

class TF_BuildingLoadedState extends TransferState {
  TF_BuildingLoadedState(this.item);
  List<SelectDestinationDropdownModel> item;
  @override
  List<Object> get props => [item];
}

class TF_BuildingErrorState extends TransferState {
  const TF_BuildingErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

////
class TF_RoomLoadingState extends TransferState {
  const TF_RoomLoadingState();
  @override
  List<Object> get props => [];
}

class TF_RoomLoadedState extends TransferState {
  TF_RoomLoadedState(this.item);
  List<SelectDestinationDropdownModel> item;
  @override
  List<Object> get props => [item];
}

class TF_RoomErrorState extends TransferState {
  const TF_RoomErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

// ///
// class TF_LocationLoadingState extends TransferState {
//   const TF_LocationLoadingState();
//   @override
//   List<Object> get props => [];
// }

// class TF_LocationLoadedState extends TransferState {
//   TF_LocationLoadedState(this.item);
//   List<SelectDestinationDropdownModel> item;
//   @override
//   List<Object> get props => [item];
// }

// class TF_LocationErrorState extends TransferState {
//   const TF_LocationErrorState(this.error);
//   final String error;

//   @override
//   List<Object> get props => [error];
// }

///
class TF_OwnerLoadingState extends TransferState {
  const TF_OwnerLoadingState();
  @override
  List<Object> get props => [];
}

class TF_OwnerLoadedState extends TransferState {
  TF_OwnerLoadedState(this.item);
  List<SelectDestinationDropdownModel> item;
  @override
  List<Object> get props => [item];
}

class TF_OwnerErrorState extends TransferState {
  const TF_OwnerErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

///
class TF_AssetPostLoadingState extends TransferState {
  const TF_AssetPostLoadingState();
  @override
  List<Object> get props => [];
}

class TF_AssetPostLoadedState extends TransferState {
  TF_AssetPostLoadedState();

  @override
  List<Object> get props => [];
}

class TF_AssetPostErrorState extends TransferState {
  const TF_AssetPostErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
