import 'dart:async';

import 'package:entry_assignment/core/models/news/ArticleModel.dart';
import 'package:entry_assignment/core/models/news/NewsModel.dart';
import 'package:entry_assignment/helper/keys.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';

class DBService {
  DBService._();

  static final DBService db = DBService._();
  Database _database;
  int id = 100;

  String newsTable = ("CREATE TABLE if not exists news ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "urlToImage TEXT NOT NULL,"
      "description TEXT NOT NULL,"
      "title TEXT NOT NULL,"
      "source TEXT"
      ")");
  String moviesTable =
      "CREATE TABLE movies(id INTEGER PRIMARY KEY,poster_image TEXT,imdb_rating REAL,trailer_videoUrl TEXT)";
  String nearbyLocations =
      "CREATE TABLE nearbylocation(id INTEGER PRIMARY KEY,poster_image TEXT,latitude REAL,longitude REAL,name TEXT)";

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    return await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'network_database.db'),
      onCreate: (db, version) {
        db.execute(newsTable);
        db.execute(moviesTable);
        db.execute(nearbyLocations);
      },
      version: 1,
    );
  }

  Future<Database> insertData(String key, dynamic dynamicModel) async {
    final db = await database;
    var batch = db.batch();
    if (dynamicModel is NewsModel) {
      print(dynamicModel.articles.length);
      dynamicModel.articles.map((e) {
        Map<String, dynamic> newMap = Map();
        newMap = {
          'title': e.title,
          'urlToImage': e.urlToImage,
          'description': e.description,
          'source': '{id: ${e.source.id}, name : ${e.source.name}}',
        };
        batch.insert('news', newMap,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }).toList();
    }
    await batch.commit(continueOnError: true, noResult: true);
    var response = db.query('news');
    // print(response.then((value) => print(value)));
  }

  Future<NewsModel> readData(String key, int limit) async {
    final db = await database;
    switch (key) {
      case Keys.News:
        var response = await db.query("news", limit: limit);
        print(response);
        NewsModel newsModel = NewsModel("ok", response.length,
            response.map((e) => ArticleModel.fromJson(e)).toList());
        // print(newsModel.toJson());
        return newsModel;
        // print(newsModel.articles[0].source.name);
        // if (response.isNotEmpty) {
        String hello = "{id:name,name:password}";
        print(hello);

      // }

      // var newResponse =
      //     response.map((e) => e['source'] = jsonDecode(e['source']));
      // print(newResponse);
      // ArticleModel articleModel = ArticleModel.fromJson(
      //     response[0]['source'] = jsonDecode(response[0]['source']));

      // ArticleModel().toJson();
    }
  }
}
