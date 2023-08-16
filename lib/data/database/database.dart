import 'dart:io';

import 'package:drift/drift.dart';

// These imports are used to open the database
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:ams_count/data/models/test_unit/serial_data_response.dart';

import '../models/serial_view_test/serial_database_response.dart';
import 'tables.dart';

part 'database.g.dart';

// @DriftDatabase(
//   // relative import for the drift file. Drift also supports `package:`
//   // imports
//   include: {'tables.drift'},
// )
// class AppDb extends _$AppDb {
//   AppDb() : super(_openConnection());
//
//   @override
//   int get schemaVersion => 1;
// }

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [
  Serials,
], views: [
  SerialsView
])
class AppDb extends _$AppDb {
  // AppDb(super.e);

  // we tell the database where to store the data with this constructor
  AppDb() : super(_openConnection());

  // AppDb(QueryExecutor e): super(e);

  @override
  int get schemaVersion => 4;

  Future<List<Serial>> getSerialAll() {
    return (select(serials)..orderBy([(t) => OrderingTerm(expression: t.testPass)])).get();
  }


  Future<List<Serial>> getCountSerialAll() {
    return (select(serials)..orderBy([(t) => OrderingTerm(expression: t.testPass)])).get();
  }

  Future<List<Serial>> getSerial(String s) {
    return (select(serials)
          ..where((tbl) => tbl.serialUnit.equals(s))
          ..orderBy([(t) => OrderingTerm(expression: t.testPass)]))
        .get();
  }

  Future<SerialResponse> getSerialByProdNo(String s) async {
    SerialResponse result = SerialResponse();

    if(s.isEmpty){
      //get All
      var serialResult = await ((select(serials)
        // ..where((tbl) => tbl.serialUnit.equals(s))
        ..orderBy([(t) => OrderingTerm(expression: t.testPass)]))
          .get());
      result.serial = serialResult;

      result.listSerial = await (select(serials)
        //..where((tbl) => tbl.prdOrderNo.equals(prdOrderNo ?? ""))
        ..orderBy([(t) => OrderingTerm(expression: t.serialUnit)]))
          .get();
      return result;
    }else {
      var serialResult = await ((select(serials)
        ..where((tbl) => tbl.serialUnit.equals(s))
        ..orderBy([(t) => OrderingTerm(expression: t.testPass)]))
          .get());
      result.serial = serialResult;

      var prdOrderNo = serialResult.first.prdOrderNo;
      result.listSerial = await (select(serials)
        ..where((tbl) => tbl.prdOrderNo.equals(prdOrderNo ?? ""))
        ..orderBy([(t) => OrderingTerm(expression: t.serialUnit)]))
          .get();
      return result; //(select(serials)..where((tbl) => tbl.prdOrderNo.equals(prdOrderNo??""))..orderBy([(t) => OrderingTerm(expression: t.serialUnit)])).get();
    }
  }

  // returns the generated id
  Future<int> addSerial(SerialsCompanion entry) {
    return into(serials).insert(entry);
  }

  Future<int> removeSerial(String serial) {
    return (delete(serials)..where((t) => t.serialUnit.equals(serial))).go();
  }

  Future<int> removeAllSerial( ) {
    return (delete(serials)).go();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
