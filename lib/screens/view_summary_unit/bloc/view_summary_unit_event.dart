part of 'view_summary_unit_bloc.dart';

abstract class ViewSummaryUnitEvent extends Equatable {
  const ViewSummaryUnitEvent();

  @override
  List<Object?> get props => [];
}

class ViewSummaryUnitFetch extends ViewSummaryUnitEvent {
  final String serialNo;
  final bool isOffline;

  const ViewSummaryUnitFetch({
    required this.serialNo,
    required this.isOffline,
  });

  @override
  List<Object?> get props => [serialNo, isOffline];
}

