part of 'auth_bloc.dart';

//enum LoginStatus { fetching, success, failed, init }

class AuthState extends Equatable {
  final FetchStatus status;
  final String dialogMessage;

  const AuthState({this.status = FetchStatus.init, this.dialogMessage = ""});

  AuthState copyWith({
    FetchStatus? status,
    String? dialogMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}
