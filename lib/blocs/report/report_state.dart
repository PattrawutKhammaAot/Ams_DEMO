part of 'report_bloc.dart';

class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class GetListCountDetailLoadingState extends ReportState {
  const GetListCountDetailLoadingState();
  @override
  List<Object> get props => [];
}

class GetListCountDetailLoadedState extends ReportState {
  const GetListCountDetailLoadedState(this.item);
  final List<ListCountDetailReportModel> item;

  @override
  List<Object> get props => [item];
}

class GetListCountDetailErrorState extends ReportState {
  const GetListCountDetailErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
