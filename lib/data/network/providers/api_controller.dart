import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../app.dart';
import '../../../blocs/network/network.dart';
import '../../models/api_response.dart';
import '../../../widgets/widget.dart';
import 'api_service.dart';
import 'dio_exception.dart';

class APIController {
  Future<void> exceptionHandle(Object exception) async {
    try {
      if (exception.toString() == 'Unauthorized') {
        AlertSnackBar.show(
            title: 'Session timeout',
            message: 'Your session has timed out. Please login again',
            type: ReturnStatus.WARNING,
            crossPage: true);

        navigateToLogin();
      } else if (exception.toString().contains('Connection refused')) {
        // BuildContext? context = Get.context;
        await AlertConfirmDialog.alert(
            context: GlobalContextService.navigatorKey.currentContext!,
            title: 'Connection Error',
            description:
                'It is not possible to connect to the server at this time. The network connection was lost.',
            textConfirm: 'OK',
            onPressed: () {});
      } else {
        AlertSnackBar.show(
            title: "Network Exception",
            message: exception.toString(),
            type: ReturnStatus.ERROR);
        //throw (exception.toString());
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  void navigateToLogin() {
    // Navigator.pushNamed(
    //     GlobalContextService.navigatorKey.currentContext!, '/login');
  }

  Future<dynamic> getData(String function, String param,
      {bool useAuth = true}) async {
    try {
      // await initConnectivity();
      // if (connectionStatus.value == ConnectivityResult.none)
      //   throw 'No internet connection';
      if (NetworkBloc().state is NetworkFailure) {
        throw 'No internet connection';
      }

      final appService = ApiService();
      await appService.init();
      var resp = await appService.get(function, param, useAuth: useAuth);
      if (resp.statusCode == 200) {
        // if (resp.data["status_code"] == "LOGOUT") {
        //   Alert.show(
        //       message: 'Session timeout',
        //       type: ReturnStatus.WARNING,
        //       crossPage: true);
        //
        //   navigateToLogin();
        //   return;
        // }
      } else if (resp.statusCode == 401) {
        navigateToLogin();
        return;
      } else {
        AlertSnackBar.show(
            message: 'Failed in calling a API', type: ReturnStatus.WARNING);
      }

      return resp.data;
    } on DioError catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      final errorMessage = DioExceptions.fromDioError(exception).toString();
      await exceptionHandle(errorMessage);
      throw errorMessage;
    }
  }

  Future<dynamic> postData(String function, Map data,
      {bool useAuth = true}) async {
    try {
      // await initConnectivity();
      // if (connectionStatus.value == ConnectivityResult.none)
      //   throw 'No internet connection';
      if (NetworkBloc().state is NetworkFailure) {
        throw 'No internet connection';
      }

      final appService = ApiService();
      await appService.init();
      var resp = await appService.post(function, data,
          useAuth: useAuth); //.then((resp) async {

      if (resp.statusCode == 200) {
        if (resp.data["status"] == "LOGOUT") {
          AlertSnackBar.show(
              message: 'Session timeout', type: ReturnStatus.WARNING);
          navigateToLogin();
          return;
        }

        if (resp.data["status"] == "SUCCESS") {
          if (resp.data["message"] != 'Search Success' &&
              resp.data["message"] != 'Get Success' &&
              resp.data["message"] != '') {
            AlertSnackBar.show(
                message: resp.data["message"],
                type:
                    statusFromString(ReturnStatus.values, resp.data["status"]));
          }
          return resp.data;
        } else {
          if (kDebugMode) {
            print("Failed to call post");
          }
          AlertSnackBar.show(
              message: resp.data["message"],
              type: statusFromString(ReturnStatus.values, resp.data["status"]));
          return resp.data;
        }
      } else if (resp.statusCode == 401) {
        navigateToLogin();
        return;
      } else {
        AlertSnackBar.show(
            message: 'Failed in calling a API', type: ReturnStatus.WARNING);
      }
    }
    // catch (exception) {
    //   if (exception.toString() == 'Unauthorized') {
    //     Alert.show(message: 'Session timeout', type: ReturnStatus.WARNING);
    //     navigateToLogin();
    //   } else {
    //     if (kDebugMode) {
    //       print(exception);
    //     }
    //     Alert.show(message: exception.toString(), type: ReturnStatus.ERROR);
    //     throw (exception.toString());
    //   }
    // }
    on DioError catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      final errorMessage = DioExceptions.fromDioError(exception).toString();
      await exceptionHandle(errorMessage);
      //Alert.show(message: errorMessage, type: ReturnStatus.ERROR);
      throw errorMessage;
    }
  }

  Future<dynamic> postJsonData(String function, String data,
      {bool useAuth = true}) async {
    try {
      // await initConnectivity();
      // if (connectionStatus.value == ConnectivityResult.none)
      //   throw 'No internet connection';
      if (NetworkBloc().state is NetworkFailure) {
        throw 'No internet connection';
      }

      final appService = ApiService();
      await appService.init();
      var resp = await appService.postJson(function, data, useAuth: useAuth);

      if (resp.statusCode == 200) {
        // if (resp.data["status_code"] == "LOGOUT") {
        //   Alert.show(message: 'Session timeout', type: ReturnStatus.WARNING);
        //   navigateToLogin();
        //   return;
        // }
        //
        // if (resp.data["status_code"] == "SUCCESS") {
        //   if (resp.data["message"] != 'Search Success' &&
        //       resp.data["message"] != 'Get Success' &&
        //       resp.data["message"] != '') {
        //     Alert.show(
        //         message: resp.data["message"],
        //         type: statusFromString(
        //             ReturnStatus.values, resp.data["status_code"]));
        //   }
        //   return resp.data;
        // } else {
        //   if (kDebugMode) {
        //     print("Failed to call post");
        //   }
        //   Alert.show(
        //       message: resp.data["message"],
        //       type: statusFromString(
        //           ReturnStatus.values, resp.data["status_code"]));
        //   return resp.data;
        // }
        return resp.data;
      } else if (resp.statusCode == 401) {
        navigateToLogin();
        return;
      } else {
        AlertSnackBar.show(
            message: 'Failed in calling a API', type: ReturnStatus.WARNING);
      }
    }
    // catch (exception) {
    //   if (exception.toString() == 'Unauthorized') {
    //     Alert.show(message: 'Session timeout', type: ReturnStatus.WARNING);
    //     navigateToLogin();
    //   } else {
    //     if (kDebugMode) {
    //       print(exception);
    //     }
    //     Alert.show(message: exception.toString(), type: ReturnStatus.ERROR);
    //     throw (exception.toString());
    //   }
    // }
    on DioError catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      final errorMessage = DioExceptions.fromDioError(exception).toString();
      await exceptionHandle(errorMessage);
      //Alert.show(message: errorMessage, type: ReturnStatus.ERROR);
      throw errorMessage;
    }
  }
}
