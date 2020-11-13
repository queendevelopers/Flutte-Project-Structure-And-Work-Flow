import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
void createDatabse() async{
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'newsApi.db'),
    onCreate: (db, version) {
      return db.execute("CREATE TABLE newsApi(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",);
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
}


}