import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ams_count/config/app_data.dart';
import 'package:validators/validators.dart';

import '../../../config/api_path.dart';

part 'connection_setting_event.dart';

part 'connection_setting_state.dart';

class ConnectionSettingBloc extends Bloc<ConnectionSettingEvent, ConnectionSettingState> {
  ConnectionSettingBloc() : super(ConnectionSettingInitial()) {
    on<ConnectionSettingEvent>((event, emit) async {});

    on<LoadSetting>(_onLoadSetting);
    on<TestConnection>(_onTestConnection);
    on<Submit>(_onSubmit);
  }

  Future<FutureOr<void>> _onLoadSetting(LoadSetting event, Emitter<ConnectionSettingState> emit) async {
    emit(ConnectionLoading());
    try {
      var connectionUrl = await AppData.getApiUrl();
      emit(LoadedSetting(connectionUrl ?? apiHint));
    } catch (e) {
      //emit(const ErrorMessage("Save Failed"));
      emit(ConnectionSettingInitial());
    }
  }

  Future<FutureOr<void>> _onTestConnection(TestConnection event, Emitter<ConnectionSettingState> emit) async {
    emit(ConnectionLoading());
    try {
      if (!isURL(event.apiUrl)) {
        emit(const ErrorMessage('Invalid URL'));
      } else {
        if (event.apiUrl.isNotEmpty) {
          await Future.delayed(const Duration(seconds: 5));
          // AppData.setApiUrl(event.apiUrl);

          final dio = Dio();
          dio.httpClientAdapter = IOHttpClientAdapter(
            onHttpClientCreate: (_){
              // Don't trust any certificate just because their root cert is trusted.
              final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: false));
              // You can test the intermediate / root cert here. We just ignore it.
              client.badCertificateCallback = (cert, host, port) => true;
              return client;
            },
          );
          final response = await dio.get('${event.apiUrl.replaceAll(RegExp(r'/$'), '')}/Authenticate/testconnection');
          if (kDebugMode) {
            print(response);
          }
          if (response.statusCode == 200) {
            emit(TestConnectionSuccess());
          } else {
            emit(const ErrorMessage("Test connection failed."));
          }
        } else {
          emit(const ErrorMessage("Connection url can't be empty"));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(const ErrorMessage("Test connection failed."));
    }
  }

  Future<void> _onSubmit(Submit event, Emitter<ConnectionSettingState> emit) async {
    emit(ConnectionLoading());
    try {
      // await Future.delayed(const Duration(seconds: 5));
      if (event.apiUrl.isNotEmpty) {
        AppData.setApiUrl(event.apiUrl);
        emit(SaveSuccess());
      } else {
        emit(const ErrorMessage("Connection url can't be empty"));
      }
    } catch (e) {
      emit(const ErrorMessage("Save Failed"));
    }
  }
}
