import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../main.dart';

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
    try {
      await db.execute('CREATE TABLE ${CheckAllField.TABLE_NAME} ('
          '${QuickTypes.ID_PRIMARYKEY},'
          '${CheckAllField.UNCHECK} ${QuickTypes.INTEGER},'
          '${CheckAllField.CHECK} ${QuickTypes.INTEGER},'
          '${CheckAllField.TOTAL} ${QuickTypes.INTEGER}'
          ')');
      var itemRespone = await query(db);

      if (itemRespone.isEmpty) {
        insert({
          '${CheckAllField.UNCHECK}': 0,
          '${CheckAllField.CHECK}': 0,
          '${CheckAllField.TOTAL}': 0,
        }, db);
      }
    } catch (e, s) {
      printInfo(info: "$e");
      printInfo(info: "$s");
    }
  }

  Future<int> insert(Map<String, dynamic> data, Database db) async {
    try {
      return await db.insert(CheckAllField.TABLE_NAME, data);
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<int> update({int? uncheck, int? check, int? total}) async {
    final db = await databaseInitialState.database;

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

  Future<List<Map<String, dynamic>>> query(Database db) async {
    try {
      return await db.query(CheckAllField.TABLE_NAME);
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    }
  }
}

class CheckAllField {
  static const String TABLE_NAME = 't_checkAll';
  static const String ID = 'ID';
  static const String UNCHECK = 'uncheckScore';
  static const String CHECK = 'checkScore';
  static const String TOTAL = 'total';
}
