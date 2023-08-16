
import 'package:drift/drift.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
// part 'database.g.dart';

// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Serial".
class Serials extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get orderId => text().nullable()();
  TextColumn get prdOrderNo => text().nullable()();
  TextColumn get itemCode => text().nullable()();
  IntColumn get quantity => integer().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get serialUnit => text().nullable()();
  RealColumn get rMin => real().nullable()();
  RealColumn get rMax => real().nullable()();
  RealColumn get cuF0 => real().nullable()();
  RealColumn get cuF10 => real().nullable()();
  RealColumn get hvTest => real().nullable()();
  //for store in client
  RealColumn get cL1L2 => real().nullable()();
  RealColumn get cL2L3 => real().nullable()();
  RealColumn get cL3L1 => real().nullable()();
  BoolColumn get isSend => boolean().nullable()();
  TextColumn get testPass => text().nullable()();
}

// // This will make drift generate a class called "Category" to represent a row in
// // this table. By default, "Categorie" would have been used because it only
// //strips away the trailing "s" in the table name.
// @DataClassName('Category')
// class Categories extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get description => text()();
// }

abstract class SerialsView extends View {
  Serials get serials;

  @override
  Query as() => select([
        serials.orderId,
        serials.prdOrderNo,
        serials.itemCode,
        serials.quantity,
        serials.description,
        serials.serialUnit,
        serials.rMin,
        serials.rMax,
        serials.cuF0,
        serials.cuF10,
        serials.hvTest,
        serials.cL1L2,
        serials.cL2L3,
        serials.cL3L1,
        serials.isSend,
        serials.testPass,
      ]).from(serials);
}

// // this annotation tells drift to prepare a database class that uses both of the
// // tables we just defined. We'll see how to use that database class in a moment.
// @DriftDatabase(tables: [Serials,], views: [SerialsView])
// class AppDb extends _$AppDb {
//   AppDb(QueryExecutor e): super(e);
//
//   @override
//   int get schemaVersion => 1;
// }
