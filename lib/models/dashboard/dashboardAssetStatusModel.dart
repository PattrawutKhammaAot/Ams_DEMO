import 'package:sqflite/sqflite.dart';

import '../../data/database/dbsqlite.dart';
import '../../data/database/quickTypes/quickTypes.dart';

class DashBoardAssetStatusModel {
  DashBoardAssetStatusModel({
    this.ID,
    this.RESULT_ALL,
    this.RESULT_NORMAL,
    this.RESULT_REPAIR,
    this.RESULT_BORROW,
    this.RESULT_SALE,
    this.RESULT_WRITEOFF,
  });
  final int? ID;
  int? RESULT_ALL;
  int? RESULT_NORMAL;
  int? RESULT_REPAIR;
  int? RESULT_BORROW;
  int? RESULT_SALE;
  int? RESULT_WRITEOFF;

  List<Object> get props => [
        ID!,
        RESULT_ALL!,
        RESULT_NORMAL!,
        RESULT_REPAIR!,
        RESULT_BORROW!,
        RESULT_SALE!,
        RESULT_WRITEOFF!,
      ];

  static DashBoardAssetStatusModel fromJson(dynamic json) {
    return DashBoardAssetStatusModel(
      ID: json[DashboardField.ID],
      RESULT_ALL: json[DashboardField.RESULT_ALL],
      RESULT_NORMAL: json[DashboardField.RESULT_NORMAL],
      RESULT_REPAIR: json[DashboardField.RESULT_REPAIR],
      RESULT_BORROW: json[DashboardField.RESULT_BORROW],
      RESULT_SALE: json[DashboardField.RESULT_SALE],
      RESULT_WRITEOFF: json[DashboardField.RESULT_WRITEOFF],
    );
  }

  Map<String, dynamic> toJson() => {
        DashboardField.ID: ID,
        DashboardField.RESULT_ALL: RESULT_ALL,
        DashboardField.RESULT_NORMAL: RESULT_NORMAL,
        DashboardField.RESULT_REPAIR: RESULT_REPAIR,
        DashboardField.RESULT_BORROW: RESULT_BORROW,
        DashboardField.RESULT_SALE: RESULT_SALE,
        DashboardField.RESULT_WRITEOFF: RESULT_WRITEOFF,
      };

  createTable(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${DashboardField.TABLE_NAME} ('
        '${QuickTypes.ID_PRIMARYKEY},'
        '${DashboardField.RESULT_ALL} ${QuickTypes.INTEGER},'
        '${DashboardField.RESULT_NORMAL} ${QuickTypes.INTEGER},'
        '${DashboardField.RESULT_REPAIR} ${QuickTypes.INTEGER},'
        '${DashboardField.RESULT_BORROW} ${QuickTypes.INTEGER},'
        '${DashboardField.RESULT_SALE} ${QuickTypes.INTEGER},'
        '${DashboardField.RESULT_WRITEOFF} ${QuickTypes.INTEGER}'
        ')');
    // var itemRespone = await query();
    // if (itemRespone.isEmpty) {
    //   insert({
    //     '${DashboardField.RESULT_ALL}': 1,
    //     '${DashboardField.RESULT_NORMAL}': 1,
    //     '${DashboardField.RESULT_REPAIR}': 1,
    //     '${DashboardField.RESULT_BORROW}': 1,
    //     '${DashboardField.RESULT_SALE}': 1,
    //     '${DashboardField.RESULT_WRITEOFF}': 1,
    //   });
    // }
  }

  Future<int> insert(Map<String, dynamic> data) async {
    try {
      final db = await DbSqlite().database;
      return await db.insert(DashboardField.TABLE_NAME, data);
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> query() async {
    Database db = await DbSqlite().database;
    bool databaseExists = await databaseFactory.databaseExists(db.path);

    if (databaseExists == true) {
      return await db.query(DashboardField.TABLE_NAME);
    } else {
      return [];
    }
  }

  Future<int> update({
    required Map<String, Object?> values,
  }) async {
    final Database db = await DbSqlite().database;

    try {
      return await db.update(DashboardField.TABLE_NAME, values);
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    }
  }
}

class DashboardField {
  static const String TABLE_NAME = 't_DashBaord';
  static const String ID = 'ID';
  static const String RESULT_ALL = 'resultAll';
  static const String RESULT_NORMAL = 'resultNormal';
  static const String RESULT_REPAIR = 'resultRepair';
  static const String RESULT_BORROW = 'resultBorrow';
  static const String RESULT_SALE = 'resultSale';
  static const String RESULT_WRITEOFF = 'resultWriteOff';
}
