part of 'report_bloc.dart';

class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class ReportObserve extends ReportEvent {}

class GetListCountDetailForReportEvent extends ReportEvent {
  GetListCountDetailForReportEvent(this.planCode);

  String planCode;

  @override
  List<Object> get prop => [planCode];
}
