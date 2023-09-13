part of 'authenticate_bloc.dart';

class AuthenticateEvent extends Equatable {
  const AuthenticateEvent();

  @override
  List<Object> get props => [];
}

class AuthenticateObserve extends AuthenticateEvent {}

class LogoutEvent extends AuthenticateEvent {
  const LogoutEvent(this.username);
  final LogoutModel? username;
  @override
  List<Object> get props => [username!];
}
