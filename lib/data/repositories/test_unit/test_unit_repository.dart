import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';


import '../../../main.dart';
import '../../database/database.dart' as database;
import '../../models/default_response.dart';
import '../../models/test_unit/serial_data_response.dart';
import '../../models/test_unit/test_unit_request.dart';
import '../../network/providers/api_controller.dart';

class TestUnitRepository {
  Future<List<Serial>> getSerial(String serial) async {
    // final _changeEmailController = StreamController<ResetPasswordState>();
    List<Serial> result = [];
    try {
      var apiController = APIController();
      var response = await apiController.getData('TestUnit/GetBySerial', 'serial=$serial', useAuth: false);

      var objJsonResponse = SerialDataResponse.fromJson(response);
      if (objJsonResponse.result ?? false) {
        result = objJsonResponse.data!.serial!;
      } else {
        //throw objJsonResponse.message ?? "";
        result = [];
        throw (objJsonResponse.message ?? "");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
    // finally {
    //   // _changeEmailController.add(AuthenticationStatus.unauthenticated);
    // }
    return result;
  }

  Future<DefaultResponse> sendSerial(TestUnitRequest requestData) async {
    // final _changeEmailController = StreamController<ResetPasswordState>();
    DefaultResponse result = DefaultResponse();
    try {
      var apiController = APIController();

      var response = await apiController.postJsonData('TestUnit/SendSerial', json.encode(requestData), useAuth: false);

      var objJsonResponse = DefaultResponse.fromJson(response);
      if (objJsonResponse.result == "SUCCESS") {
        for (var element in requestData.data!) {
          await appDb.removeSerial(element.serial!.toString());
        }

        result = objJsonResponse;
      } else {
        //throw objJsonResponse.message ?? "";
        result = DefaultResponse();
        throw (objJsonResponse.message ?? "");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
    // finally {
    //   // _changeEmailController.add(AuthenticationStatus.unauthenticated);
    // }
    return result;
  }

  Future<int> saveSerial(Serial serial) async {
    int result = -1;
    try {
      // final appDb = database.AppDb(NativeDatabase.memory());
      var insertedId = await appDb.addSerial(database.SerialsCompanion(
        orderId: Value(serial.orderId),
        prdOrderNo: Value(serial.prdOrderNo),
        itemCode: Value(serial.itemcode),
        quantity: Value(serial.quantity),
        description: Value(serial.description),
        serialUnit: Value(serial.serialUnit),
        rMin: Value(serial.rMin),
        rMax: Value(serial.rMax),
        cuF0: Value(serial.cuF0),
        cuF10: Value(serial.cuF10),
        hvTest: Value(serial.hvTest),
        cL1L2: Value(serial.cL1L2),
        cL2L3: Value(serial.cL2L3),
        cL3L1: Value(serial.cL3L1),
        isSend: Value(serial.isSend),
        testPass: Value(serial.testPass),
      ));

      result = insertedId;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
    return result;
  }

  Future<int> removeSerial(List<String> serials) async {
    int result = -1;
    try {
      for (var serial in serials) {
        await appDb.removeSerial(serial);
      }
      // result = insertedId;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
    return result;
  }

  Future<int> removeAllSerial() async {
    int result = -1;
    try {
      await appDb.removeAllSerial();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
    return result;
  }

// void dispose() => _controller.close();
}
