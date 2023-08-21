import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:ams_count/data/models/test_unit/serial_data_response.dart';

import '../../../main.dart';
import '../../models/serial_view_test/serial_view_offline_response.dart';
import '../../models/serial_view_test/serial_view_test_response.dart';
import '../../network/providers/api_controller.dart';

import '../../database/database.dart' as database;

class ViewSummaryUnitRepository {
  Future<List<ViewTest>> getSerialViewTest(String serial) async {
    List<ViewTest> result = [];
    try {
      var apiController = APIController();
      var response = await apiController.getData('TestUnit/GetBySerialViewTest', 'serial=$serial', useAuth: false);

      var objJsonResponse = SerialViewTestResponse.fromJson(response);
      if (objJsonResponse.viewTest != null) {
        result = objJsonResponse.viewTest!;
      } else {
        //throw objJsonResponse.message ?? "";
        result = [];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    } finally {
      // _changeEmailController.add(AuthenticationStatus.unauthenticated);
    }
    return result;
  }

  Future<SerialViewOfflineResponse> getSerialViewTestFromLocalDb(String serial) async {
    SerialViewOfflineResponse result = SerialViewOfflineResponse();
    try {
      if (kDebugMode) {
        var respAll = await appDb.getSerialAll();
        // print(respAll);
      }

      var resp = await appDb.getSerialByProdNo(serial);

      if (resp.listSerial != null) {
        var resultListResponse = resp.listSerial!
            .map((r) => ViewTest(
                  serialUnit: int.parse(r.serialUnit!),
                  orderId: r.orderId  != null ? int.parse(r.orderId!) : null,
                  prdOrderNo: r.prdOrderNo ?? "",
                  itemcode: r.itemCode ?? "",
                  description: r.description ?? "",
                  quantity: r.quantity,
                  countSerial: 1, //r.quantity,
                  testPass: r.testPass,
                ))
            .toList();

        var sResponse = resp.serial!.map((r) => Serial(
            id : r.id,
            orderId : r.orderId?? "",
            prdOrderNo : r.prdOrderNo ?? "",
            itemcode : r.itemCode ?? "",
            quantity : r.quantity,
            description : r.description ?? "",
            serialUnit : r.serialUnit,
            rMin : r.rMin,
            rMax : r.rMax,
            cuF0 : r.cuF0,
            cuF10 : r.cuF10,
            hvTest : r.hvTest,
            cL1L2 : r.cL1L2,
            cL2L3 : r.cL2L3,
            cL3L1 : r.cL3L1,
            isSend : r.isSend,
            testPass : r.testPass,
        )).toList();

        var respAll = await appDb.getSerialAll();
        result.totalSerial = respAll.length;
        result.serial = sResponse; //resp.serial;
        result.listViewTest = resultListResponse;
      } else {
        //throw objJsonResponse.message ?? "";
        //result = [];
      }
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
