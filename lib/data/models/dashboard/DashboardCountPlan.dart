// To parse this JSON data, do
//
//     final dashboardCountPlan = dashboardCountPlanFromJson(jsonString);

import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../../database/dbsqlite.dart';
import '../../database/quickTypes/quickTypes.dart';

DashboardCountPlan dashboardCountPlanFromJson(String str) =>
    DashboardCountPlan.fromJson(json.decode(str));

String dashboardCountPlanToJson(DashboardCountPlan data) =>
    json.encode(data.toJson());

class DashboardCountPlan {
  Data? data;
  final String? status;
  final String? message;

  DashboardCountPlan({
    this.data,
    this.status,
    this.message,
  });

  factory DashboardCountPlan.fromJson(Map<String, dynamic> json) =>
      DashboardCountPlan(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  late final int? resultAll;
  late final int? resultOpen;
  final int? resultCounting;
  final int? resultClose;

  Data({
    this.resultAll,
    this.resultOpen,
    this.resultCounting,
    this.resultClose,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        resultAll: json["resultAll"],
        resultOpen: json["resultOpen"],
        resultCounting: json["resultCounting"],
        resultClose: json["resultClose"],
      );

  Map<String, dynamic> toJson() => {
        "resultAll": resultAll,
        "resultOpen": resultOpen,
        "resultCounting": resultCounting,
        "resultClose": resultClose,
      };
  createTable(Database db, int newVersion) async {
    await db.execute('CREATE TABLE t_dashboardPlanCount ('
        '${QuickTypes.ID_PRIMARYKEY},'
        'resultAll ${QuickTypes.INTEGER},'
        'resultOpen ${QuickTypes.INTEGER},'
        'resultCounting ${QuickTypes.INTEGER},'
        'resultClose ${QuickTypes.INTEGER}'
        ')');
  }

  Future<int> insert(Map<String, dynamic> data) async {
    try {
      final db = await DbSqlite().database;
      return await db.insert("t_dashboardPlanCount", data);
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> query() async {
    Database db = await DbSqlite().database;

    bool databaseExists = await databaseFactory.databaseExists(db.path);

    if (databaseExists == true) {
      return await db.query('t_dashboardPlanCount');
    } else {
      return [];
    }
  }

  Future<int> update(Map<String, dynamic> data) async {
    try {
      final db = await DbSqlite().database;
      return await db.update('t_dashboardPlanCount', data);
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }
}
