part of 'check_version_app_data_bloc.dart';

class CheckVersionAppDataEvent extends Equatable {
  const CheckVersionAppDataEvent();

  @override
  List<Object> get props => [];
}

class CheckAppVersionObserver extends CheckVersionAppDataEvent {}

class CheckAppVersionEvent extends CheckVersionAppDataEvent {
  const CheckAppVersionEvent(this.buildNumber);
  final int? buildNumber;
  @override
  List<Object> get props => [buildNumber!];
}
