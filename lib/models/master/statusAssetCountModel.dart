import 'package:sqflite/sqflite.dart';

import '../../data/database/dbsqlite.dart';
import '../../data/database/quickTypes/quickTypes.dart';

class StatusAssetCountModel {
  const StatusAssetCountModel(
      {this.STATUS_NAME, this.STATUS_ID, this.STATUS_CODE, this.ID});
  final int? ID;
  final int? STATUS_ID;
  final String? STATUS_CODE;
  final String? STATUS_NAME;

  List<Object> get props => [ID!, STATUS_ID!, STATUS_CODE!, STATUS_NAME!];

  static StatusAssetCountModel fromJson(dynamic json) {
    return StatusAssetCountModel(
      STATUS_ID: json[StatusAssetField.STATUS_ID],
      STATUS_CODE: json[StatusAssetField.STATUS_CODE],
      STATUS_NAME: json[StatusAssetField.STATUS_NAME],
    );
  }

  Map<String, dynamic> toJson() => {
        StatusAssetField.ID: ID,
        StatusAssetField.STATUS_ID: STATUS_ID,
        StatusAssetField.STATUS_CODE: STATUS_CODE,
        StatusAssetField.STATUS_NAME: STATUS_NAME,
      };
  createTable(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${StatusAssetField.TABLE_NAME} ('
        '${QuickTypes.ID_PRIMARYKEY},'
        '${StatusAssetField.STATUS_ID} ${QuickTypes.INTEGER},'
        '${StatusAssetField.STATUS_CODE} ${QuickTypes.TEXT},'
        '${StatusAssetField.STATUS_NAME} ${QuickTypes.TEXT}'
        ')');
  }

  Future<List<Map<String, dynamic>>> query() async {
    Database db = await DbSqlite().database;
    return await db.query(StatusAssetField.TABLE_NAME);
  }

  Future<int> insert(StatusAssetCountModel data) async {
    try {
      final db = await DbSqlite().database;
      return await db.insert(StatusAssetField.TABLE_NAME, data.toJson());
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<void> insertOrUpdate(StatusAssetCountModel data) async {
    final db = await DbSqlite().database;

    List<Map<String, dynamic>> existingRows = await db.query(
      StatusAssetField.TABLE_NAME,
      where: "${StatusAssetField.STATUS_ID} = ?",
      whereArgs: [data.STATUS_ID],
    );

    if (existingRows.isNotEmpty) {
      // Update existing data
      await db.update(
        StatusAssetField.TABLE_NAME,
        data.toJson(),
        where: "${StatusAssetField.STATUS_ID} = ?",
        whereArgs: [data.STATUS_ID],
      );
    } else {
      // Insert new data
      await db.insert(
        StatusAssetField.TABLE_NAME,
        data.toJson(),
      );
    }
  }
}

class StatusAssetField {
  static const String TABLE_NAME = 't_statusAssetField';
  static const String ID = 'ID';
  static const String STATUS_ID = 'statusId';
  static const String STATUS_CODE = 'statusCode';
  static const String STATUS_NAME = 'statusName';
}
