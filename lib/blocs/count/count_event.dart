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
