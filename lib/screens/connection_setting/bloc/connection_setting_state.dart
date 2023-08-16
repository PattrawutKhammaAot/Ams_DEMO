part of 'connection_setting_bloc.dart';

abstract class ConnectionSettingState extends Equatable {
  const ConnectionSettingState();
}

class ConnectionSettingInitial extends ConnectionSettingState {
  @override
  List<Object> get props => [];
}

class LoadedSetting extends ConnectionSettingState{
  const LoadedSetting(this.connectionUrl);

  final String connectionUrl;

  @override
  List<Object> get props => [connectionUrl];
}

class ConnectionLoading extends ConnectionSettingState{
  @override
  List<Object?> get props => [];
}

class SaveSuccess extends ConnectionSettingState{
  @override
  List<Object?> get props => [];
}


class TestConnectionSuccess extends ConnectionSettingState{
  @override
  List<Object?> get props => [];
}

class ErrorMessage extends ConnectionSettingState{
  const ErrorMessage(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
