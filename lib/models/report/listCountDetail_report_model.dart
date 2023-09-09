import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../main.dart';
import '../../data/database/dbsqlite.dart';
import '../../data/database/quickTypes/quickTypes.dart';

class ListCountDetailReportModel {
  const ListCountDetailReportModel({
    this.ID,
    this.PLAN_CODE,
    this.ASSET_CODE,
    this.ASSET_NAME,
    this.BEFORE_LOCATION_ID,
    this.BEFORE_LOCATION_CODE,
    this.BEFORE_LOCATION_NAME,
    this.NEW_LOCATION_ID,
    this.NEW_LOCATION_CODE,
    this.NEW_LOCATION_NAME,
    this.BEFORE_DEPARTMENT_ID,
    this.BEFORE_DEPARTMENT_CODE,
    this.BEFORE_DEPARTMENT_NAME,
    this.NEW_DEPARTMENT_ID,
    this.NEW_DEPARTMENT_CODE,
    this.NEW_DEPARTMENT_NAME,
    this.CHECK_DATE,
    this.STATUS_CHECK,
    this.STATUS_NAME,
    this.REMARK,
    this.QTY,
    this.ASSET_SERIAL_NO,
    this.ASSET_DATE_OF_USE,
    this.CLASS_NAME,
  });
  final int? ID;
  final String? PLAN_CODE;
  final String? ASSET_CODE;
  final String? ASSET_NAME;
  final int? BEFORE_LOCATION_ID;
  final String? BEFORE_LOCATION_CODE;
  final String? BEFORE_LOCATION_NAME;
  final int? NEW_LOCATION_ID;
  final String? NEW_LOCATION_CODE;
  final String? NEW_LOCATION_NAME;
  final int? BEFORE_DEPARTMENT_ID;
  final String? BEFORE_DEPARTMENT_CODE;
  final String? BEFORE_DEPARTMENT_NAME;
  final int? NEW_DEPARTMENT_ID;
  final String? NEW_DEPARTMENT_CODE;
  final String? NEW_DEPARTMENT_NAME;
  final String? CHECK_DATE;
  final String? STATUS_CHECK;
  final String? STATUS_NAME;
  final String? REMARK;
  final int? QTY;
  final String? ASSET_SERIAL_NO;
  final String? ASSET_DATE_OF_USE;
  final String? CLASS_NAME;
  List<Object> get props => [
        ID!,
        PLAN_CODE!,
        ASSET_CODE!,
        ASSET_NAME!,
        BEFORE_LOCATION_ID!,
        BEFORE_LOCATION_CODE!,
        BEFORE_LOCATION_NAME!,
        NEW_LOCATION_ID!,
        NEW_LOCATION_CODE!,
        NEW_LOCATION_NAME!,
        BEFORE_DEPARTMENT_ID!,
        BEFORE_DEPARTMENT_CODE!,
        BEFORE_DEPARTMENT_NAME!,
        NEW_DEPARTMENT_ID!,
        NEW_DEPARTMENT_CODE!,
        NEW_DEPARTMENT_NAME!,
        CHECK_DATE!,
        STATUS_CHECK!,
        STATUS_NAME!,
        REMARK!,
        QTY!,
        ASSET_SERIAL_NO!,
        ASSET_DATE_OF_USE!,
        CLASS_NAME!,
      ];

  static ListCountDetailReportModel fromJson(dynamic json) {
    return ListCountDetailReportModel(
      ID: json[ListCountDetailReportField.ID],
      PLAN_CODE: json[ListCountDetailReportField.PLAN_CODE],
      ASSET_CODE: json[ListCountDetailReportField.ASSET_CODE],
      ASSET_NAME: json[ListCountDetailReportField.ASSET_NAME],
      BEFORE_LOCATION_ID: json[ListCountDetailReportField.BEFORE_LOCATION_ID],
      BEFORE_LOCATION_CODE:
          json[ListCountDetailReportField.BEFORE_LOCATION_CODE],
      BEFORE_LOCATION_NAME:
          json[ListCountDetailReportField.BEFORE_LOCATION_NAME],
      NEW_LOCATION_ID: json[ListCountDetailReportField.NEW_LOCATION_ID],
      NEW_LOCATION_CODE: json[ListCountDetailReportField.NEW_LOCATION_CODE],
      NEW_LOCATION_NAME: json[ListCountDetailReportField.NEW_LOCATION_NAME],
      BEFORE_DEPARTMENT_ID:
          json[ListCountDetailReportField.BEFORE_DEPARTMENT_ID],
      BEFORE_DEPARTMENT_CODE:
          json[ListCountDetailReportField.BEFORE_DEPARTMENT_CODE],
      BEFORE_DEPARTMENT_NAME:
          json[ListCountDetailReportField.BEFORE_DEPARTMENT_NAME],
      NEW_DEPARTMENT_ID: json[ListCountDetailReportField.NEW_DEPARTMENT_ID],
      NEW_DEPARTMENT_CODE: json[ListCountDetailReportField.NEW_DEPARTMENT_CODE],
      NEW_DEPARTMENT_NAME: json[ListCountDetailReportField.NEW_DEPARTMENT_NAME],
      CHECK_DATE: json[ListCountDetailReportField.CHECK_DATE],
      STATUS_CHECK: json[ListCountDetailReportField.STATUS_CHECK],
      STATUS_NAME: json[ListCountDetailReportField.STATUS_NAME],
      REMARK: json[ListCountDetailReportField.REMARK],
      QTY: json[ListCountDetailReportField.QTY],
      ASSET_SERIAL_NO: json[ListCountDetailReportField.ASSET_SERIAL_NO],
      ASSET_DATE_OF_USE: json[ListCountDetailReportField.ASSET_DATE_OF_USE],
      CLASS_NAME: json[ListCountDetailReportField.CLASS_NAME],
    );
  }

  Map<String, dynamic> toJson() => {
        ListCountDetailReportField.ID: ID,
        ListCountDetailReportField.PLAN_CODE: PLAN_CODE,
        ListCountDetailReportField.ASSET_CODE: ASSET_CODE,
        ListCountDetailReportField.ASSET_NAME: ASSET_NAME,
        ListCountDetailReportField.BEFORE_LOCATION_ID: BEFORE_LOCATION_ID,
        ListCountDetailReportField.BEFORE_LOCATION_CODE: BEFORE_LOCATION_CODE,
        ListCountDetailReportField.BEFORE_LOCATION_NAME: BEFORE_LOCATION_NAME,
        ListCountDetailReportField.NEW_LOCATION_ID: NEW_LOCATION_ID,
        ListCountDetailReportField.NEW_LOCATION_CODE: NEW_LOCATION_CODE,
        ListCountDetailReportField.NEW_LOCATION_NAME: NEW_LOCATION_NAME,
        ListCountDetailReportField.BEFORE_DEPARTMENT_ID: BEFORE_DEPARTMENT_ID,
        ListCountDetailReportField.BEFORE_DEPARTMENT_CODE:
            BEFORE_DEPARTMENT_CODE,
        ListCountDetailReportField.BEFORE_DEPARTMENT_NAME:
            BEFORE_DEPARTMENT_NAME,
        ListCountDetailReportField.NEW_DEPARTMENT_ID: NEW_DEPARTMENT_ID,
        ListCountDetailReportField.NEW_DEPARTMENT_CODE: NEW_DEPARTMENT_CODE,
        ListCountDetailReportField.NEW_DEPARTMENT_NAME: NEW_DEPARTMENT_NAME,
        ListCountDetailReportField.CHECK_DATE: CHECK_DATE,
        ListCountDetailReportField.STATUS_CHECK: STATUS_CHECK,
        ListCountDetailReportField.STATUS_NAME: STATUS_NAME,
        ListCountDetailReportField.REMARK: REMARK,
        ListCountDetailReportField.QTY: QTY,
        ListCountDetailReportField.ASSET_SERIAL_NO: ASSET_SERIAL_NO,
        ListCountDetailReportField.ASSET_DATE_OF_USE: ASSET_DATE_OF_USE,
        ListCountDetailReportField.CLASS_NAME: CLASS_NAME,
      };
  createTable(Database db, int newVersion) async {
    try {
      await db.execute('CREATE TABLE ${ListCountDetailReportField.TABLE_NAME} ('
          '${QuickTypes.ID_PRIMARYKEY},'
          '${ListCountDetailReportField.PLAN_CODE} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.ASSET_CODE} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.ASSET_NAME} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.BEFORE_LOCATION_ID} ${QuickTypes.INTEGER},'
          '${ListCountDetailReportField.BEFORE_LOCATION_CODE} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.BEFORE_LOCATION_NAME} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.NEW_LOCATION_ID} ${QuickTypes.INTEGER},'
          '${ListCountDetailReportField.NEW_LOCATION_CODE} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.NEW_LOCATION_NAME} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.BEFORE_DEPARTMENT_ID} ${QuickTypes.INTEGER},'
          '${ListCountDetailReportField.BEFORE_DEPARTMENT_CODE} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.BEFORE_DEPARTMENT_NAME} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.NEW_DEPARTMENT_ID} ${QuickTypes.INTEGER},'
          '${ListCountDetailReportField.NEW_DEPARTMENT_CODE} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.NEW_DEPARTMENT_NAME} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.CHECK_DATE} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.STATUS_CHECK} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.STATUS_NAME} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.REMARK} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.ASSET_SERIAL_NO} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.ASSET_DATE_OF_USE} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.CLASS_NAME} ${QuickTypes.TEXT},'
          '${ListCountDetailReportField.QTY} ${QuickTypes.INTEGER}'
          ')');
      printInfo(
          info: 'CREATE TABLE ${ListCountDetailReportField.TABLE_NAME} ('
              '${QuickTypes.ID_PRIMARYKEY},'
              '${ListCountDetailReportField.PLAN_CODE} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.ASSET_CODE} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.ASSET_NAME} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.BEFORE_LOCATION_ID} ${QuickTypes.INTEGER},'
              '${ListCountDetailReportField.BEFORE_LOCATION_CODE} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.BEFORE_LOCATION_NAME} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.NEW_LOCATION_ID} ${QuickTypes.INTEGER},'
              '${ListCountDetailReportField.NEW_LOCATION_CODE} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.NEW_LOCATION_NAME} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.BEFORE_DEPARTMENT_ID} ${QuickTypes.INTEGER},'
              '${ListCountDetailReportField.BEFORE_DEPARTMENT_CODE} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.BEFORE_DEPARTMENT_NAME} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.NEW_DEPARTMENT_ID} ${QuickTypes.INTEGER},'
              '${ListCountDetailReportField.NEW_DEPARTMENT_CODE} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.NEW_DEPARTMENT_NAME} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.CHECK_DATE} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.STATUS_CHECK} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.STATUS_NAME} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.REMARK} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.ASSET_SERIAL_NO} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.ASSET_DATE_OF_USE} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.CLASS_NAME} ${QuickTypes.TEXT},'
              '${ListCountDetailReportField.QTY} ${QuickTypes.INTEGER}'
              ')');
    } catch (e, s) {
      printInfo(info: e.toString());
      printInfo(info: s.toString());
    }
  }

  Future<int> insert(Map<String, dynamic> data) async {
    printInfo(info: "$data");
    try {
      final db = await databaseInitialState.database;
      return await db.insert(ListCountDetailReportField.TABLE_NAME, data);
    } on Exception catch (ex) {
      print(ex);

      EasyLoading.showError(ex.toString());
      rethrow;
    }
  }

  Future<int> insertNot(Map<String, dynamic> data) async {
    printInfo(info: "$data");
    try {
      final db = await databaseInitialState.database;
      return await db.insert(ListCountDetailReportField.TABLE_NAME, data);
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> query() async {
    final db = await databaseInitialState.database;
    bool databaseExists = await databaseFactory.databaseExists(db.path);

    if (databaseExists == true) {
      return await db.query(ListCountDetailReportField.TABLE_NAME);
    } else {
      return [];
    }
  }

  Future<int> updateForRemarkAndStatusCheck({
    String? assetCode,
    String? planCode,
    String? remark = '',
    String? statusId = '',
  }) async {
    try {
      final db = await databaseInitialState.database;
      return await db.update(
        ListCountDetailReportField.TABLE_NAME,
        {
          'remark': remark,
          'statusName': statusId,
          'statusCheck': "Checked",
          'checkDate': DateFormat('yyyy-MM-dd').format(DateTime.now())
        },
        where:
            '${ListCountDetailReportField.ASSET_CODE} = ? AND ${ListCountDetailReportField.PLAN_CODE} = ?',
        whereArgs: [assetCode, planCode],
      );
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<int> updateForAssetAndPlan({
    String? assetCode,
    String? planCode,
    String? remark = '',
    int? locationid = 0,
    int? departmentid = 0,
    String? statusId = '',
    String? statusCheck = '',
    String? checkDate = '',
    String? locationName = '',
    String? departmentName = '',
    String? serialNo = '',
    String? classname = '',
    String? useDate = '',
  }) async {
    try {
      final db = await databaseInitialState.database;
      return await db.update(
        ListCountDetailReportField.TABLE_NAME,
        {
          'remark': remark,
          'statusName': statusId,
          'beforeLocationId': locationid,
          'beforeDepartmentId': departmentid,
          'statusCheck': statusCheck,
          'checkDate': checkDate,
          'beforeLocationName': locationName,
          'beforeDepartmentName': departmentName,
          ListCountDetailReportField.ASSET_SERIAL_NO: serialNo,
          ListCountDetailReportField.ASSET_DATE_OF_USE: useDate,
          ListCountDetailReportField.CLASS_NAME: classname,
        },
        where:
            '${ListCountDetailReportField.ASSET_CODE} = ? AND ${ListCountDetailReportField.PLAN_CODE} = ?',
        whereArgs: [assetCode, planCode],
      );
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> querySelectColumn({
    String? assetCode,
  }) async {
    final db = await databaseInitialState.database;
    bool databaseExists = await databaseFactory.databaseExists(db.path);

    if (databaseExists == true) {
      var query = await db.query(
        ListCountDetailReportField.TABLE_NAME,
        columns: [
          ListCountDetailReportField.PLAN_CODE,
          ListCountDetailReportField.ASSET_NAME,
          ListCountDetailReportField.ASSET_CODE,
          ListCountDetailReportField.STATUS_NAME,
          ListCountDetailReportField.BEFORE_DEPARTMENT_ID,
          ListCountDetailReportField.BEFORE_LOCATION_ID,
          ListCountDetailReportField.CHECK_DATE,
          ListCountDetailReportField.REMARK,
          ListCountDetailReportField.STATUS_CHECK,
          ListCountDetailReportField.ASSET_SERIAL_NO,
          ListCountDetailReportField.ASSET_DATE_OF_USE,
          ListCountDetailReportField.CLASS_NAME,
        ],
        where: '${ListCountDetailReportField.ASSET_CODE} = ?',
        whereArgs: [assetCode], // แทนค่าใน where clause
      );

      return query;
    } else {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> queryListCheck({
    String? statusCheck,
  }) async {
    final db = await databaseInitialState.database;
    bool databaseExists = await databaseFactory.databaseExists(db.path);

    if (databaseExists == true) {
      var query = await db.query(
        ListCountDetailReportField.TABLE_NAME,
        columns: [
          ListCountDetailReportField.STATUS_CHECK,
        ],
        where: '${ListCountDetailReportField.STATUS_CHECK} = ?',
        whereArgs: [statusCheck], // แทนค่าใน where clause
      );

      return query;
    } else {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> queryPlan({
    String? plan,
  }) async {
    final db = await databaseInitialState.database;
    bool databaseExists = await databaseFactory.databaseExists(db.path);

    if (databaseExists == true) {
      var query = await db.query(
        ListCountDetailReportField.TABLE_NAME,
        columns: [
          ListCountDetailReportField.STATUS_CHECK,
        ],
        where: '${ListCountDetailReportField.PLAN_CODE} = ?',
        whereArgs: [plan], // แทนค่าใน where clause
      );

      return query;
    } else {
      return [];
    }
  }
}

class ListCountDetailReportField {
  static const String TABLE_NAME = 't_listCountDetailReport';
  static const String ID = 'ID';
  static const String PLAN_CODE = 'planCode';
  static const String ASSET_CODE = 'assetCode';
  static const String ASSET_NAME = 'assetName';
  static const String BEFORE_LOCATION_ID = 'beforeLocationId';
  static const String BEFORE_LOCATION_CODE = 'beforeLocationCode';
  static const String BEFORE_LOCATION_NAME = 'beforeLocationName';
  static const String NEW_LOCATION_ID = 'newLocationId';
  static const String NEW_LOCATION_CODE = 'newLocationCode';
  static const String NEW_LOCATION_NAME = 'newLocationName';
  static const String BEFORE_DEPARTMENT_ID = 'beforeDepartmentId';
  static const String BEFORE_DEPARTMENT_CODE = 'beforeDepartmentCode';
  static const String BEFORE_DEPARTMENT_NAME = 'beforeDepartmentName';
  static const String NEW_DEPARTMENT_ID = 'newDepartmentId';
  static const String NEW_DEPARTMENT_CODE = 'newDepartmentCode';
  static const String NEW_DEPARTMENT_NAME = 'newDepartmentName';
  static const String CHECK_DATE = 'checkDate';
  static const String STATUS_CHECK = 'statusCheck';
  static const String STATUS_NAME = 'statusName';
  static const String REMARK = 'remark';
  static const String ASSET_SERIAL_NO = 'assetSerialNo';
  static const String ASSET_DATE_OF_USE = 'assetDateOfUse';
  static const String CLASS_NAME = 'className';
  static const String QTY = 'qty';
}
