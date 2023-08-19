part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeObserve extends HomeEvent {}

class HomeScrollChanged extends HomeEvent {
  const HomeScrollChanged(this.scroll);

  final bool scroll;

  @override
  List<Object> get props => [scroll];
}

class HomeLoadJobs extends HomeEvent {
  const HomeLoadJobs(this.data);

  final String data;

  @override
  List<Object> get props => [data];
}

class HomeEvent_LoadCountDashboard extends HomeEvent {}
