import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../config/app_data.dart';
import '../../../main.dart';
import '../../database/database.dart' as database;
import '../../models/auth_token.dart';
import '../../models/default_response.dart';
import '../../models/test_unit/serial_data_response.dart';
import '../../models/test_unit/test_unit_request.dart';
import '../../network/providers/api_controller.dart';

class LoginRepository {

  Future<DefaultResponse> LoginUser(String userName,String passWord) async {
    DefaultResponse result = DefaultResponse();
    try {

      var params = {
        "username": userName,
        "password": passWord,
      };

      var apiController = APIController();
      var response = await apiController.postData('Authenticate/login',params, useAuth: false);

      if (response["token"] == null){
        var objJsonResponse = DefaultResponse.fromJson(response);
        return objJsonResponse;
      }
      var TokenResult = AuthToken.fromJson(response);
      AppData.setToken(TokenResult.token!.token);
      AppData.setUser(TokenResult.token!.id.toString());
      AppData.setUserName(TokenResult.token!.username);
      AppData.setLocalId(TokenResult.token!.localId);

      var objJsonResponse = DefaultResponse.fromJson(response);
      if (TokenResult.status == "SUCCESS") {
        result = objJsonResponse;
      } else {
        result = DefaultResponse();
        throw (objJsonResponse.message ?? "");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
    return result;

  }
}
