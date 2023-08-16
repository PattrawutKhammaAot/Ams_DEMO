part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();


  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeIsScrollState extends HomeState {} 

class HomeIsNotScrollState extends HomeState {} 


class HomeLoading extends HomeState {


  @override
  String toString() => 'TodosLoading';
}

class HomeLoaded extends HomeState {
  const HomeLoaded(this.dashboardCountPlan);

  final DashboardCountPlan dashboardCountPlan;

  @override
  List<Object> get props => [dashboardCountPlan];
}

class HomeNotLoaded extends HomeState {
  @override
  String toString() => 'HomeNotLoaded';
}

