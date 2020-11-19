import 'dart:convert';
import 'dart:io';

import 'package:entry_assignment/core/api_keys.dart';
import 'package:entry_assignment/core/models/github/github_model.dart';
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
          await DBService.db.insertData(newsModel);
          return newsModel;
        case Keys.Movies:
          MovieModel movieModel =
              MovieModel.fromJson(jsonDecode(response.body));
          await Future.wait(movieModel.results.map((e) async {
            var omdbResponse = await client.get(
                rebuildUrl(
                    WebAddress.omdbApiBaseUrl, WebAddress.omdbApiSerarchMovie, {
                  'apikey': APIKeys.omdbAPI,
                  't': e.title.replaceAll(" ", "+")
                }),
                headers: {HttpHeaders.contentTypeHeader: 'application/json'});
            print(omdbResponse.body);
            MovieResults movieResults =
                MovieResults.fromJson(jsonDecode(omdbResponse.body));
            e.Poster = movieResults.Poster;
            e.imdbRating = movieResults.imdbRating;

            print(e.Poster);
          }).toList());
          print('I was waiting');
          await DBService.db.insertData(movieModel);
          return movieModel;

        case Keys.GitHub:
          var list = jsonDecode(response.body) as List;
          List<GitHubModel> gitHubModel =
              list.map((e) => GitHubModel.fromJson(e)).toList();
          print('printing $gitHubModel');
          await DBService.db.insertData(gitHubModel);
          return gitHubModel;
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
