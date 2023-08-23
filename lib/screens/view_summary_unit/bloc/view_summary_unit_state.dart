// part of 'view_summary_unit_bloc.dart';

// class ViewSummaryUnitState extends Equatable {
//   // const ViewSummaryUnitState();

//   final List<ViewTest> items;
//   final List<Serial>? serial;
//   final FetchStatus status;
//   final int totalSerial;

//   const ViewSummaryUnitState({
//     this.items = const [],
//     this.serial,
//     this.status = FetchStatus.init,
//     this.totalSerial = 0,
//   });

//   ViewSummaryUnitState copyWith({
//     List<ViewTest>? items,
//     List<Serial>? serial,
//     FetchStatus? status,
//     int? totalSerial,
//   }) {
//     return ViewSummaryUnitState(
//       items: items ?? this.items,
//       serial: serial ?? this.serial,
//       status: status ?? this.status,
//       totalSerial: totalSerial ?? this.totalSerial,
//     );
//   }

//   @override
//   List<Object> get props => [
//         items,
//         // serial,
//         status,
//         totalSerial
//       ];
// }

// class ViewSummaryUnitInitial extends ViewSummaryUnitState {
//   @override
//   List<Object> get props => [];
// }
