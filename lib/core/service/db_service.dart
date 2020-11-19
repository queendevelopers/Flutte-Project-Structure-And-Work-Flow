import 'dart:async';
import 'dart:convert';

import 'package:entry_assignment/core/models/github/github_model.dart';
import 'package:entry_assignment/core/models/news/ArticleModel.dart';
import 'package:entry_assignment/core/models/news/NewsModel.dart';
import 'package:entry_assignment/core/models/omdb_tmdb/MovieModel.dart';
import 'package:entry_assignment/core/models/omdb_tmdb/MovieResults.dart';
import 'package:entry_assignment/helper/keys.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';

class DBService {
  DBService._();

  static final DBService db = DBService._();
  Database _database;

  String newsTable = ("CREATE TABLE if not exists news ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "urlToImage TEXT NOT NULL,"
      "description TEXT NOT NULL,"
      "title TEXT NOT NULL,"
      "source TEXT"
      ")");
  String moviesTable =
      "CREATE TABLE movies(id INTEGER PRIMARY KEY,title TEXT, trailer TEXT,Poster TEXT,imdbRating TEXT)";
  String nearbyLocations =
      "CREATE TABLE nearbylocation(id INTEGER PRIMARY KEY,poster_image TEXT,latitude REAL,longitude REAL,name TEXT)";
  String githubTable =
      "CREATE TABLE github(id INTEGER, name TEXT,html_url TEXT,description TEXT)";

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
        db.execute(githubTable);
      },
      version: 1,
    );
  }

  Future<Database> insertData(dynamic dynamicModel) async {
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
          'source': jsonEncode(e.source),
        };
        batch.insert('news', newMap,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }).toList();
    }

    if (dynamicModel is MovieModel) {
      print(dynamicModel.results.length);
      dynamicModel.results.map((e) {
        Map<String, dynamic> newMap = Map();
        newMap = {
          'title': e.title,
          'trailer': e.trailer,
          'Poster': e.Poster,
          'imdbRating': e.imdbRating,
        };
        batch.insert('movies', newMap,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }).toList();
    }

    if (dynamicModel is List<GitHubModel>) {
      List<GitHubModel> githubModels = await readData(Keys.GitHub, null);
      if (githubModels.isNotEmpty) {
      } else {
        dynamicModel.map((e) {
          Map<String, dynamic> newMap = Map();
          newMap = {
            'id': e.id,
            'name': e.name,
            'description': e.description,
            'html_url': e.html_url,
          };
          batch.insert('github', newMap,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }).toList();
      }
    }
    await batch.commit(continueOnError: true, noResult: true);
  }

  Future<dynamic> readData(String key, int limit) async {
    final db = await database;
    switch (key) {
      case Keys.News:
        var response = await db.query("news", limit: limit, orderBy: 'id DESC');
        print(response);
        NewsModel newsModel = NewsModel("ok", response.length,
            response.map((e) => ArticleModel.fromJson(e)).toList());
        return newsModel;

      case Keys.Movies:
        var response =
            await db.query("movies", limit: limit, orderBy: 'id DESC');
        print(response);
        MovieModel movieModel =
            MovieModel(response.map((e) => MovieResults.fromJson(e)).toList());

        return movieModel;

      case Keys.GitHub:
        var response = await db.query("github");
        List<GitHubModel> githubModelList =
            response.map((e) => GitHubModel.fromJson(e)).toList();
        return githubModelList;
    }
  }
}
