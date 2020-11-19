import 'dart:convert';
import 'dart:io';

import 'package:entry_assignment/core/api_keys.dart';
import 'package:entry_assignment/core/models/news/NewsModel.dart';
import 'package:entry_assignment/core/models/omdb_tmdb/MovieModel.dart';
import 'package:entry_assignment/core/models/omdb_tmdb/MovieResults.dart';
import 'package:entry_assignment/core/service/db_service.dart';
import 'package:entry_assignment/helper/keys.dart';
import 'package:entry_assignment/helper/web_address.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Uri rebuildUrl(
      String baseUrl, unencodedPath, Map<String, String> params) {
    return Uri.https(baseUrl, unencodedPath, params);
  }

  static Future<dynamic> getData(
      http.Client client, Uri uri, String key) async {
    print(uri);
    final response = await client
        .get(uri, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    print('status code ${response.statusCode}');
    if (response.statusCode == 200) {
      switch (key) {
        case Keys.News:
          NewsModel newsModel = NewsModel.fromJson(jsonDecode(response.body));
          await DBService.db.insertData(Keys.News, newsModel);
          return newsModel;
          break;
        case Keys.Movies:
          MovieModel movieModel =
              MovieModel.fromJson(jsonDecode(response.body));

          movieModel.results.map((e) async {
            final omdbResponse = await client.get(
                rebuildUrl(
                    WebAddress.omdbApiBaseUrl, WebAddress.omdbApiSerarchMovie, {
                  'apikey': APIKeys.omdbAPI,
                  't': e.title.replaceAll(" ", "+")
                }),
                headers: {HttpHeaders.contentTypeHeader: 'application/json'});
            MovieResults movieResults =
                MovieResults.fromJson(jsonDecode(omdbResponse.body));
            e.Poster = movieResults.Poster;
            e.imdbRating = movieResults.imdbRating;

            print(e.title);
          }).toList();

          await DBService.db.insertData(Keys.Movies, movieModel);
          return movieModel;

          break;
      }
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<NewsModel> getPaces(http.Client client, Uri uri) async {
    print(uri);
    final response = await client.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    });
    print('status code ${response.statusCode}');
    if (response.statusCode == 200) {
      return NewsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
