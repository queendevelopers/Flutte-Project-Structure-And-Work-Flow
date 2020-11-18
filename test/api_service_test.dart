import 'dart:io';

import 'package:entry_assignment/core/api_keys.dart';
import 'package:entry_assignment/core/models/news/NewsModel.dart';
import 'package:entry_assignment/core/models/omdb_tmdb/MovieModel.dart';
import 'package:entry_assignment/core/service/api_service.dart';
import 'package:entry_assignment/helper/keys.dart';
import 'package:entry_assignment/helper/web_address.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  Uri latestNewsUri = ApiService.rebuildUrl(WebAddress.newsApiBaseUrl,
      WebAddress.newsLatest, {'q': 'Bitcoin', 'apiKey': APIKeys.newsAPI});

  Uri nowShowingMoviesUri = ApiService.rebuildUrl(WebAddress.tmdbApiBaseUrl,
      WebAddress.tmdbApiNowShowingMovies, {'api_key': APIKeys.tmdpAPI});

  String latestNewsLocalPath =
      await rootBundle.loadString('assets/json/latestnews.json');
  String nowShowingMoviesLocalPath =
      await rootBundle.loadString('assets/json/nowshowing_movies.json');

  group('getData', () {
    test('returns a Post if the http call completes successfully', () async {
      final client = MockClient();
      final movieClient = MockClient();
      when(client.get(latestNewsUri, headers: {
        HttpHeaders.contentTypeHeader: 'application/json'
      })).thenAnswer(
          (realInvocation) async => http.Response(latestNewsLocalPath, 200));
      when(movieClient.get(nowShowingMoviesUri,
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}))
          .thenAnswer((realInvocation) async =>
              http.Response(nowShowingMoviesLocalPath, 200));
      expect(await ApiService.getData(client, latestNewsUri, Keys.News),
          isA<NewsModel>());
      expect(
          await ApiService.getData(
              movieClient, nowShowingMoviesUri, Keys.Movies),
          isA<MovieModel>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      when(client.get(latestNewsUri,
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      when(client.get(nowShowingMoviesUri,
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(ApiService.getData(client, latestNewsUri, Keys.News),
          throwsException);
      expect(ApiService.getData(client, nowShowingMoviesUri, Keys.Movies),
          throwsException);
    });
  });
}
