import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/database/dbsqlite.dart';
import '../../data/database/quickTypes/quickTypes.dart';

class ResponseModel {
  ResponseModel({
    this.DATA,
    this.STATUS,
    this.MESSAGE,
  });
  int? DATA;
  final String? STATUS;
  final String? MESSAGE;

  List<Object> get props => [DATA!, STATUS!, MESSAGE!];

  static ResponseModel fromJson(dynamic json) {
    return ResponseModel(
      DATA: json['data'],
      STATUS: json['status'],
      MESSAGE: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'data': DATA,
        'status': STATUS,
        'message': MESSAGE,
      };

  createTable(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${CheckAllField.TABLE_NAME} ('
        '${QuickTypes.ID_PRIMARYKEY},'
        '${CheckAllField.UNCHECK} ${QuickTypes.INTEGER},'
        '${CheckAllField.CHECK} ${QuickTypes.INTEGER},'
        '${CheckAllField.TOTAL} ${QuickTypes.INTEGER}'
        ')');
    var itemRespone = await ResponseModel().query();
    if (itemRespone.isEmpty) {
      insert({
        '${CheckAllField.UNCHECK}': 0,
        '${CheckAllField.CHECK}': 0,
        '${CheckAllField.TOTAL}': 0,
      });
    }
  }

  Future<int> insert(Map<String, dynamic> data) async {
    try {
      final db = await DbSqlite().database;
      return await db.insert(CheckAllField.TABLE_NAME, data);
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<int> update({int? uncheck, int? check, int? total}) async {
    final Database db = await DbSqlite().database;

    try {
      String sql =
          "UPDATE ${CheckAllField.TABLE_NAME} SET ${CheckAllField.UNCHECK} = '${uncheck}', ${CheckAllField.CHECK} = '${check}', ${CheckAllField.TOTAL} = '${total}'";

      return await db.rawUpdate(sql);
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    }
  }

  Future<List<Map<String, dynamic>>> query() async {
    Database db = await DbSqlite().database;
    return await db.query(CheckAllField.TABLE_NAME);
  }
}

class CheckAllField {
  static const String TABLE_NAME = 't_checkAll';
  static const String ID = 'ID';
  static const String UNCHECK = 'uncheckScore';
  static const String CHECK = 'checkScore';
  static const String TOTAL = 'total';
}
