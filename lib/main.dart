import 'package:ams_count/data/database/dbsqlite.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbSqlite().initializeDatabase();
  runApp(const App());
}
