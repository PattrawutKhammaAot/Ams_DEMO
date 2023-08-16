import 'package:drift/native.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'data/database/database.dart';


late AppDb appDb;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  appDb = AppDb();
  runApp(const App());
}
