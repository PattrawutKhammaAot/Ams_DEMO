import 'package:ams_count/models/count/listImageAssetModel.dart';
import 'package:ams_count/models/count/responeModel.dart';
import 'package:ams_count/models/master/departmentModel.dart';
import 'package:ams_count/models/master/locationModel.dart';
import 'package:ams_count/models/master/statusAssetCountModel.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

    bool isDatabaseExists = await databaseExists(dbPath);
    if (isDatabaseExists) {
      print("Database already exists");
    } else {
      var database = await openDatabase(
        dbPath,
        version: 1,
        onCreate: _createDb,
        // onUpgrade: (db, oldVersion, newVersion) =>
        //     _onUpgrade(db, oldVersion, newVersion),
      );
      print("Create a Tables Data");
      return database;
    }
    return await openDatabase(
      dbPath,
    );
  }

  void _createDb(Database db, int newVersion) async {
    ListImageAssetModel().createTable(db, newVersion);
    CountPlanModel().createTable(db, newVersion);
    ResponseModel().createTable(db, newVersion);
    DepartmentModel().createTable(db, newVersion);
    LocationModel().createTable(db, newVersion);
    StatusAssetCountModel().createTable(db, newVersion);
  }

  Future<void> deleteAll({
    String? tableName,
  }) async {
    try {
      Database db = await DbSqlite().database;
      int count = await db.delete('${tableName!}');

      printInfo(info: "Deleted Table = ${tableName}");
    } catch (e) {
      print('Error deleting from SQLite: $e');
    }
  }
}
