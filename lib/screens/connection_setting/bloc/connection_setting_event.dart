part of 'connection_setting_bloc.dart';

abstract class ConnectionSettingEvent extends Equatable {
  const ConnectionSettingEvent();

  @override
  List<Object> get props => [];
}


class LoadSetting extends ConnectionSettingEvent{
  const LoadSetting( );

  @override
  List<Object> get props => [];
}

class TestConnection extends ConnectionSettingEvent{
  const TestConnection(this.apiUrl);

  final String apiUrl;

  @override
  List<Object> get props => [apiUrl];
}

class Submit extends ConnectionSettingEvent{
  const Submit(this.apiUrl);

  final String apiUrl;

  @override
  List<Object> get props => [apiUrl];
}
