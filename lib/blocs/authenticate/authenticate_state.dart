part of 'authenticate_bloc.dart';

class AuthenticateState extends Equatable {
  const AuthenticateState();

  @override
  List<Object> get props => [];
}

class AuthenticateInitial extends AuthenticateState {}

class LogoutLoadingState extends AuthenticateState {
  const LogoutLoadingState();
  @override
  List<Object> get props => [];
}

class LogoutLoadedState extends AuthenticateState {
  const LogoutLoadedState(this.item);

  final ResponseModel item;

  @override
  List<Object> get props => [item];
}

class LogoutErrorState extends AuthenticateState {
  const LogoutErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
