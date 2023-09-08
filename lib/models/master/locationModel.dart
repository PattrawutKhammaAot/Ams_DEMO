import 'package:sqflite/sqflite.dart';

import '../../main.dart';
import '../../data/database/dbsqlite.dart';
import '../../data/database/quickTypes/quickTypes.dart';

class LocationModel {
  const LocationModel(
      {this.LOCATION_ID, this.LOCATION_CODE, this.LOCATION_NAME, this.ID});
  final int? LOCATION_ID;
  final int? ID;
  final String? LOCATION_CODE;
  final String? LOCATION_NAME;

  List<Object> get props => [
        ID!,
        LOCATION_ID!,
        LOCATION_CODE!,
        LOCATION_NAME!,
      ];

  static LocationModel fromJson(dynamic json) {
    return LocationModel(
      ID: json[LocationField.ID],
      LOCATION_ID: json[LocationField.LOCATION_ID],
      LOCATION_CODE: json[LocationField.LOCATION_CODE],
      LOCATION_NAME: json[LocationField.LOCATION_NAME],
    );
  }

  Map<String, dynamic> toJson() => {
        LocationField.ID: ID,
        LocationField.LOCATION_ID: LOCATION_ID,
        LocationField.LOCATION_CODE: LOCATION_CODE,
        LocationField.LOCATION_NAME: LOCATION_NAME,
      };

  createTable(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${LocationField.TABLE_NAME} ('
        '${QuickTypes.ID_PRIMARYKEY},'
        '${LocationField.LOCATION_ID} ${QuickTypes.INTEGER},'
        '${LocationField.LOCATION_CODE} ${QuickTypes.TEXT},'
        '${LocationField.LOCATION_NAME} ${QuickTypes.TEXT}'
        ')');
  }

  Future<int> insert(Map<String, dynamic> data) async {
    try {
      final db = await databaseInitialState.database;
      return await db.insert(LocationField.TABLE_NAME, data);
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> query() async {
    final db = await databaseInitialState.database;
    bool databaseExists = await databaseFactory.databaseExists(db.path);

    if (databaseExists == true) {
      return await db.query(LocationField.TABLE_NAME);
    } else {
      return [];
    }
  }
}

class LocationField {
  static const String TABLE_NAME = 't_location';
  static const String ID = 'ID';
  static const String LOCATION_ID = 'locationId';
  static const String LOCATION_CODE = 'locationCode';
  static const String LOCATION_NAME = 'locationName';
}
