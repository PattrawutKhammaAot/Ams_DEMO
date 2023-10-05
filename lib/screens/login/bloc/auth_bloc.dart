import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app.dart';
import '../../../main.dart';
import '../../../data/models/default_response.dart';
import '../../../data/network/providers/api_controller.dart';
import '../../../data/repositories/login/login_repository.dart';
import '../../../widgets/alert.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc._() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthInitial());
    });

    //Login
    on<AuthEvent_Login>((event, emit) async {
      try {
        final String username = event.username;
        final String password = event.password;

        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        emit(state.copyWith(status: FetchStatus.fetching));
        //EasyLoading.show(maskType: EasyLoadingMaskType.black);
        await Future.delayed(Duration(seconds: 1));
        if (username == "" && password == "") {
          emit(state.copyWith(status: FetchStatus.failed));
          //EasyLoading.dismiss();
          EasyLoading.showError("Please Enter Username Or Password !");
          //return;
        } else {
          final response =
              await LoginRepository().LoginUser(username, password);
          printInfo(info: "${response.result}");
          if (response.result == "SUCCESS") {
            emit(state.copyWith(status: FetchStatus.success));
            EasyLoading.showSuccess("Success !!!!!!!!!!!!!!");
            Get.toNamed('/');
            print("SUCCESS");
          } else if (response.result == 'WARNING') {
            printInfo(info: "Test");
          } else {
            emit(state.copyWith(status: FetchStatus.failed));
            EasyLoading.showError(response.message!);
          }
        }
      } catch (e) {
        emit(state.copyWith(status: FetchStatus.failed));
        EasyLoading.showError(e.toString());
      }
    });

    //Logout
    on<AuthEvent_Logout>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Get.toNamed('/Login');
      emit(state.copyWith(status: FetchStatus.init));
    });

    on<AutnEvent_TestConncetion>((event, emit) async {
      try {
        //emit(state.copyWith(status: FetchStatus.fetching,));
        await Future.delayed(const Duration(seconds: 1));
        // AppData.setApiUrl(event.apiUrl);
        var apiController = APIController();
        var response = await apiController
            .getData('Authenticate/TestConnection', "", useAuth: false);

        var ResultResponse = DefaultResponse.fromJson(response);
        printInfo(info: "Respone${ResultResponse.message}");
        if (kDebugMode) {
          // print(response);
        }
        if (ResultResponse.result == "Success") {
          emit(state.copyWith(
            status: FetchStatus.success,
          ));
        } else {
          AlertSnackBar.show(
              title: "WARNING",
              message:
                  "User Is Already Logged Another In From Another Device or Computer !");
          emit(state.copyWith(
            status: FetchStatus.connectionFailed,
          ));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(state.copyWith(
          status: FetchStatus.connectionFailed,
        ));
      }
    });
  }

  static final AuthBloc _instance = AuthBloc._();
  factory AuthBloc() => _instance;
}
