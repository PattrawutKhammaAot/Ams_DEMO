import 'package:sqflite/sqflite.dart';

import '../../data/database/dbsqlite.dart';
import '../../data/database/quickTypes/quickTypes.dart';

class CountPlanModel {
  const CountPlanModel(
      {this.PLAN_ID,
      this.PLAN_CODE,
      this.PLAN_DETAILS,
      this.PLAN_CHECKUSER,
      this.PLAN_CHECKDATE,
      this.PLAN_STATUS,
      this.CHECK,
      this.UNCHECK,
      this.ID});

  final int? ID;
  final int? PLAN_ID;
  final String? PLAN_CODE;
  final String? PLAN_DETAILS;
  final String? PLAN_CHECKUSER;
  final String? PLAN_CHECKDATE;
  final String? PLAN_STATUS;
  final int? CHECK;
  final int? UNCHECK;

  List<Object> get props => [
        ID!,
        PLAN_ID!,
        PLAN_CODE!,
        PLAN_DETAILS!,
        PLAN_CHECKUSER!,
        PLAN_CHECKDATE!,
        PLAN_STATUS!,
        CHECK!,
        UNCHECK!,
      ];

  static CountPlanModel fromJson(dynamic json) {
    return CountPlanModel(
      ID: json[CountPlanField.ID],
      PLAN_ID: json[CountPlanField.PLAN_ID],
      PLAN_CODE: json[CountPlanField.PLAN_CODE],
      PLAN_DETAILS: json[CountPlanField.PLAN_DETAILS],
      PLAN_CHECKUSER: json[CountPlanField.PLAN_CHECKUSER],
      PLAN_CHECKDATE: json[CountPlanField.PLAN_CHECKDATE],
      PLAN_STATUS: json[CountPlanField.PLAN_STATUS],
      CHECK: json[CountPlanField.CHECK_CHECK],
      UNCHECK: json[CountPlanField.UNCHECK],
    );
  }

  Map<String, dynamic> toJson() => {
        CountPlanField.ID: ID,
        CountPlanField.PLAN_ID: PLAN_ID,
        CountPlanField.PLAN_CODE: PLAN_CODE,
        CountPlanField.PLAN_DETAILS: PLAN_DETAILS,
        CountPlanField.PLAN_CHECKUSER: PLAN_CHECKUSER,
        CountPlanField.PLAN_CHECKDATE: PLAN_CHECKDATE,
        CountPlanField.PLAN_STATUS: PLAN_STATUS,
        CountPlanField.CHECK_CHECK: CHECK,
        CountPlanField.UNCHECK: UNCHECK,
      };

  createTable(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${CountPlanField.TABLE_NAME} ('
        '${QuickTypes.ID_PRIMARYKEY},'
        '${CountPlanField.PLAN_ID} ${QuickTypes.INTEGER},'
        '${CountPlanField.PLAN_CODE} ${QuickTypes.TEXT},'
        '${CountPlanField.PLAN_DETAILS} ${QuickTypes.TEXT},'
        '${CountPlanField.PLAN_CHECKUSER} ${QuickTypes.TEXT},'
        '${CountPlanField.PLAN_CHECKDATE} ${QuickTypes.TEXT},'
        '${CountPlanField.PLAN_STATUS} ${QuickTypes.TEXT},'
        '`${CountPlanField.CHECK_CHECK}` ${QuickTypes.INTEGER},'
        '${CountPlanField.UNCHECK} ${QuickTypes.INTEGER}'
        ')');
  }

  Future<int> insert(Map<String, dynamic> data) async {
    try {
      final db = await DbSqlite().database;

      return await db.insert(CountPlanField.TABLE_NAME, data);
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<void> addData(CountPlanModel data) async {
    var ent = await CountPlanModel().getDataById(data.ID);

    if (ent.isEmpty) {
      await CountPlanModel().insert(data.toJson());
    } else {
      await CountPlanModel().update(data, data.ID);
    }
  }

  Future<List<CountPlanModel>> getDataById(keyValue) async {
    try {
      final db = await DbSqlite().database;

      var result = await db.query(CountPlanField.TABLE_NAME,
          where: '${CountPlanField.ID} = ?', whereArgs: [keyValue]);

      return result.map((json) => CountPlanModel.fromJson(json)).toList();
    } on Exception catch (ex) {
      rethrow;
    }
  }

  Future<int> update(data, keyValue) async {
    try {
      CountPlanModel values = data;
      final db = await DbSqlite().database;
      return await db.update(CountPlanField.TABLE_NAME, values.toJson(),
          where: '${CountPlanField.ID} = ?', whereArgs: [keyValue]);
    } on Exception catch (ex) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await DbSqlite().database;
    return await db.query(CountPlanField.TABLE_NAME);
  }

  Future<void> deleteDataAllFromSQLite() async {
    try {
      Database db = await DbSqlite().database;
      int count = await db.delete(CountPlanField.TABLE_NAME);
    } catch (e) {}
  }
}

class CountPlanField {
  static const String TABLE_NAME = 't_CountPlanField';
  static const String ID = 'ID';
  static const String PLAN_ID = 'planId';
  static const String PLAN_CODE = 'planCode';
  static const String PLAN_DETAILS = 'planDetails';
  static const String PLAN_CHECKUSER = 'planCheckUser';
  static const String PLAN_CHECKDATE = 'planCheckDate';
  static const String PLAN_STATUS = 'planStatus';
  static const String CHECK_CHECK = 'check';
  static const String UNCHECK = 'uncheck';
}
