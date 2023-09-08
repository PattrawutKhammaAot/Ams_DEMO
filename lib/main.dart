import 'package:ams_count/data/database/dbsqlite.dart';
import 'package:flutter/material.dart';

import 'app.dart';

DbSqlite databaseInitialState = DbSqlite();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DbSqlite().initializeDatabase().then((value) => {runApp(const App())});
}

// Future initDatabase() async {
//   databaseInitialState = await DbSqlite();
// }
