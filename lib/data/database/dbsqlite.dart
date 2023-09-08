import 'package:ams_count/data/models/dashboard/DashboardCountPlan.dart';
import 'package:ams_count/models/count/CountScan_output.dart';
import 'package:ams_count/models/count/listImageAssetModel.dart';
import 'package:ams_count/models/count/responeModel.dart';
import 'package:ams_count/models/dashboard/dashboardAssetStatusModel.dart';
import 'package:ams_count/models/master/departmentModel.dart';
import 'package:ams_count/models/master/locationModel.dart';
import 'package:ams_count/models/master/statusAssetCountModel.dart';
import 'package:ams_count/models/report/listCountDetail_report_model.dart';
import 'package:ams_count/widgets/alert_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../main.dart';
import '../../models/count/countPlanModel.dart';

class DbSqlite {
  static DbSqlite? _dbSqlite;
  static Database? _database;

  DbSqlite._createInstance();

  factory DbSqlite() {
    if (_dbSqlite == null) {
      _dbSqlite = DbSqlite._createInstance();
    }
    return _dbSqlite!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'my_ams.db');

    // bool isDatabaseExists = await databaseExists(dbPath);

    var database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createDb,
    );

    return database;
  }

  void _createDb(Database db, int newVersion) async {
    ListImageAssetModel().createTable(db, 1);
    CountPlanModel().createTable(db, 1);
    ResponseModel().createTable(db, 1);
    DepartmentModel().createTable(db, 1);
    LocationModel().createTable(db, 1);
    StatusAssetCountModel().createTable(db, 1);
    CountScan_OutputModel().createTable(db, 1);
    DashBoardAssetStatusModel().createTable(db, 1);
    ListCountDetailReportModel().createTable(db, 1);
    Data().createTable(db, 1);
  }

  Future<void> deleteAll({
    String? tableName,
  }) async {
    try {
      final db = await databaseInitialState.database;
      await db.delete('${tableName!}');
    } catch (e) {
      print('Error deleting from SQLite: $e');
    }
  }
}
