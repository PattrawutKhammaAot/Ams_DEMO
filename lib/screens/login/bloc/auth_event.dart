part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthObserve extends AuthEvent {}

class AuthEvent_Login extends AuthEvent{
 final String username;
 final String password;

  AuthEvent_Login(this.username,this.password);
}

class AuthEvent_Logout extends AuthEvent{

}

class AutnEvent_TestConncetion extends AuthEvent{

}

