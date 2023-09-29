import 'package:ams_count/data/database/dbsqlite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'app.dart';

DbSqlite databaseInitialState = DbSqlite();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

  DbSqlite().initializeDatabase().then((value) => {runApp(const App())});
}

// Future initDatabase() async {
//   databaseInitialState = await DbSqlite();
// }
