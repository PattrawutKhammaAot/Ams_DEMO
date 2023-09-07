import 'package:ams_count/data/database/quickTypes/quickTypes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../blocs/count/count_bloc.dart';
import '../../data/database/dbsqlite.dart';

class CountScan_OutputModel {
  const CountScan_OutputModel(
      {this.ID,
      this.ASSETS_CODE,
      this.PLAN_CODE,
      this.LOCATION_ID,
      this.DEPARTMENT_ID,
      this.IS_SCAN_NOW,
      this.REMARK,
      this.STATUS_ID,
      this.STATUS_REQUEST});
  final int? ID;
  final String? ASSETS_CODE;
  final String? PLAN_CODE;
  final int? LOCATION_ID;
  final int? DEPARTMENT_ID;
  final bool? IS_SCAN_NOW;
  final String? REMARK;
  final int? STATUS_ID;
  final String? STATUS_REQUEST;

  List<Object> get props => [
        ASSETS_CODE!,
        ID!,
        PLAN_CODE!,
        LOCATION_ID!,
        DEPARTMENT_ID!,
        IS_SCAN_NOW!,
        REMARK!,
        STATUS_ID!,
        STATUS_REQUEST!,
      ];

  static CountScan_OutputModel fromJson(dynamic json) {
    return CountScan_OutputModel(
      ID: json[CountScanOutputField.ID],
      ASSETS_CODE: json[CountScanOutputField.ASSETS_CODE],
      PLAN_CODE: json[CountScanOutputField.PLAN_CODE],
      LOCATION_ID: json[CountScanOutputField.LOCATION_ID],
      DEPARTMENT_ID: json[CountScanOutputField.DEPARTMENT_ID],
      IS_SCAN_NOW: json[CountScanOutputField.IS_SCAN_NOW],
      REMARK: json[CountScanOutputField.REMARK],
      STATUS_ID: json[CountScanOutputField.STATUS_ID],
      STATUS_REQUEST: json[CountScanOutputField.STATUS_REQ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      CountScanOutputField.ASSETS_CODE: ASSETS_CODE,
      CountScanOutputField.PLAN_CODE: PLAN_CODE,
      CountScanOutputField.LOCATION_ID: LOCATION_ID,
      CountScanOutputField.DEPARTMENT_ID: DEPARTMENT_ID,
      CountScanOutputField.IS_SCAN_NOW: IS_SCAN_NOW,
      CountScanOutputField.REMARK: REMARK,
      CountScanOutputField.STATUS_ID: STATUS_ID,
      CountScanOutputField.STATUS_REQ: STATUS_REQUEST,
    };
  }

  createTable(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${CountScanOutputField.TABLE_NAME} ('
        '${QuickTypes.ID_PRIMARYKEY},'
        '${CountScanOutputField.ASSETS_CODE} ${QuickTypes.TEXT},'
        '${CountScanOutputField.PLAN_CODE} ${QuickTypes.TEXT},'
        '${CountScanOutputField.LOCATION_ID} ${QuickTypes.INTEGER},'
        '${CountScanOutputField.DEPARTMENT_ID} ${QuickTypes.INTEGER},'
        '${CountScanOutputField.IS_SCAN_NOW} ${QuickTypes.TEXT},'
        '${CountScanOutputField.REMARK} ${QuickTypes.TEXT},'
        '${CountScanOutputField.STATUS_ID} ${QuickTypes.INTEGER},'
        '${CountScanOutputField.STATUS_REQ} ${QuickTypes.TEXT}'
        ')');
  }

  Future<int> insert(CountScan_OutputModel data) async {
    try {
      final db = await DbSqlite().database;

      return await db.insert(CountScanOutputField.TABLE_NAME, data.toJson());
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<int> update(Map<String, dynamic> data, List<dynamic> keyValue) async {
    try {
      final db = await DbSqlite().database;
      return await db.update(
        CountScanOutputField.TABLE_NAME,
        data,
        where:
            '${CountScanOutputField.ASSETS_CODE} = ? AND ${CountScanOutputField.PLAN_CODE} = ?',
        whereArgs: keyValue,
      );
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<int> updateForAssetAndPlan({
    String? assetCode,
    String? planCode,
    String? remark,
    int? locationid,
    int? departmentid,
    int? statusId,
  }) async {
    try {
      final db = await DbSqlite().database;
      return await db.update(
        CountScanOutputField.TABLE_NAME,
        {
          'remark': remark,
          'statusId': statusId,
          'locationId': statusId,
          'departmentId': statusId,
        },
        where:
            '${CountScanOutputField.ASSETS_CODE} = ? AND ${CountScanOutputField.PLAN_CODE} = ?',
        whereArgs: [assetCode, planCode],
      );
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await DbSqlite().database;
    bool databaseExists = await databaseFactory.databaseExists(db.path);

    if (databaseExists == true) {
      return await db.query(CountScanOutputField.TABLE_NAME);
    } else {
      return [];
    }
  }

  Future<void> deleteDataByID(int id) async {
    try {
      Database db = await DbSqlite().database;

      int count = await db.delete(
        CountScanOutputField.TABLE_NAME,
        where: "${CountScanOutputField.ID} = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendDataToserver(BuildContext context) async {
    var itemSql = await queryAllRows();
    if (itemSql.isNotEmpty) {
      for (var item in itemSql) {
        if (item['statusRequest'] == "Checked") {
          BlocProvider.of<CountBloc>(context).add(PostCountScanAssetListEvent([
            CountScan_OutputModel(
                ASSETS_CODE: item[CountScanOutputField.ASSETS_CODE],
                PLAN_CODE: item[CountScanOutputField.PLAN_CODE],
                LOCATION_ID: item[CountScanOutputField.LOCATION_ID],
                DEPARTMENT_ID: item[CountScanOutputField.DEPARTMENT_ID],
                IS_SCAN_NOW:
                    item[CountScanOutputField.IS_SCAN_NOW] == 1 ? true : false,
                REMARK: item[CountScanOutputField.REMARK],
                STATUS_ID: item[CountScanOutputField.STATUS_ID])
          ]));
        } else if (item['statusRequest'] == "AlreadyChecked") {
          BlocProvider.of<CountBloc>(context).add(
              PostCountScanAlreadyCheckEvent(CountScan_OutputModel(
                  ASSETS_CODE: item[CountScanOutputField.ASSETS_CODE],
                  PLAN_CODE: item[CountScanOutputField.PLAN_CODE],
                  LOCATION_ID: item[CountScanOutputField.LOCATION_ID],
                  DEPARTMENT_ID: item[CountScanOutputField.DEPARTMENT_ID],
                  IS_SCAN_NOW: item[CountScanOutputField.IS_SCAN_NOW] == 1
                      ? true
                      : false,
                  REMARK: item[CountScanOutputField.REMARK],
                  STATUS_ID: item[CountScanOutputField.STATUS_ID])));
          BlocProvider.of<CountBloc>(context).add(PostCountScanSaveAssetEvent(
              CountScan_OutputModel(
                  ASSETS_CODE: item[CountScanOutputField.ASSETS_CODE],
                  PLAN_CODE: item[CountScanOutputField.PLAN_CODE],
                  LOCATION_ID: item[CountScanOutputField.LOCATION_ID],
                  DEPARTMENT_ID: item[CountScanOutputField.DEPARTMENT_ID],
                  IS_SCAN_NOW: item[CountScanOutputField.IS_SCAN_NOW] == 1
                      ? true
                      : false,
                  REMARK: item[CountScanOutputField.REMARK],
                  STATUS_ID: item[CountScanOutputField.STATUS_ID])));
        } else if (item['statusRequest'] == "notPlan") {
          BlocProvider.of<CountBloc>(context).add(
              PostCountSaveNewAssetNewPlanEvent(CountScan_OutputModel(
                  ASSETS_CODE: item[CountScanOutputField.ASSETS_CODE],
                  PLAN_CODE: item[CountScanOutputField.PLAN_CODE],
                  LOCATION_ID: item[CountScanOutputField.LOCATION_ID],
                  DEPARTMENT_ID: item[CountScanOutputField.DEPARTMENT_ID],
                  IS_SCAN_NOW: item[CountScanOutputField.IS_SCAN_NOW] == 1
                      ? true
                      : false,
                  REMARK: item[CountScanOutputField.REMARK],
                  STATUS_ID: item[CountScanOutputField.STATUS_ID])));
        }

        await deleteDataByID(item[CountScanOutputField.ID]);
      }
    }
  }
}

class CountScanOutputField {
  static const String TABLE_NAME = 't_CountScanOutputField';
  static const String ID = 'ID';
  static const String ASSETS_CODE = 'assetCode';
  static const String PLAN_CODE = 'planCode';
  static const String LOCATION_ID = 'locationId';
  static const String DEPARTMENT_ID = 'departmentId';
  static const String IS_SCAN_NOW = 'isScanNow';
  static const String REMARK = 'remark';
  static const String STATUS_ID = 'statusId';
  static const String STATUS_REQ = 'statusRequest';
}
