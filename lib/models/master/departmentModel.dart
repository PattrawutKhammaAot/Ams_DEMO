import 'package:sqflite/sqflite.dart';

import '../../main.dart';
import '../../data/database/dbsqlite.dart';
import '../../data/database/quickTypes/quickTypes.dart';

class DepartmentModel {
  const DepartmentModel({
    this.DEPARTMENT_ID,
    this.ID,
    this.DEPARTMENT_CODE,
    this.DEPARTMENT_NAME,
  });
  final int? ID;
  final int? DEPARTMENT_ID;
  final String? DEPARTMENT_CODE;
  final String? DEPARTMENT_NAME;

  List<Object> get props => [
        ID!,
        DEPARTMENT_ID!,
        DEPARTMENT_CODE!,
        DEPARTMENT_NAME!,
      ];

  static DepartmentModel fromJson(dynamic json) {
    return DepartmentModel(
      ID: json[DepartmentField.ID],
      DEPARTMENT_ID: json[DepartmentField.DEPARTMENT_ID],
      DEPARTMENT_CODE: json[DepartmentField.DEPARTMENT_CODE],
      DEPARTMENT_NAME: json[DepartmentField.DEPARTMENT_NAME],
    );
  }

  Map<String, dynamic> toJson() => {
        DepartmentField.ID: ID,
        DepartmentField.DEPARTMENT_ID: DEPARTMENT_ID,
        DepartmentField.DEPARTMENT_CODE: DEPARTMENT_CODE,
        DepartmentField.DEPARTMENT_NAME: DEPARTMENT_NAME,
      };

  createTable(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${DepartmentField.TABLE_NAME} ('
        '${QuickTypes.ID_PRIMARYKEY},'
        '${DepartmentField.DEPARTMENT_ID} ${QuickTypes.INTEGER},'
        '${DepartmentField.DEPARTMENT_CODE} ${QuickTypes.TEXT},'
        '${DepartmentField.DEPARTMENT_NAME} ${QuickTypes.TEXT}'
        ')');
  }

  Future<int> insert(Map<String, dynamic> data) async {
    try {
      final db = await databaseInitialState.database;
      return await db.insert(DepartmentField.TABLE_NAME, data);
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<int> update(Map<String, dynamic> data) async {
    try {
      final db = await databaseInitialState.database;
      return await db.update(DepartmentField.TABLE_NAME, data);
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> query() async {
    final db = await databaseInitialState.database;

    bool databaseExists = await databaseFactory.databaseExists(db.path);

    if (databaseExists == true) {
      return await db.query(DepartmentField.TABLE_NAME);
    } else {
      return [];
    }
  }
}

class DepartmentField {
  static const String TABLE_NAME = 't_department';
  static const String ID = 'ID';
  static const String DEPARTMENT_ID = 'departmentId';
  static const String DEPARTMENT_CODE = 'departmentCode';
  static const String DEPARTMENT_NAME = 'departmentName';
}
