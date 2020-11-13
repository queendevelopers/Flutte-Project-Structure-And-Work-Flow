import 'package:entry_assignment/core/api_keys.dart';
import 'package:entry_assignment/core/models/news/NewsModel.dart';
import 'package:entry_assignment/helper/web_address.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:entry_assignment/core/service/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

class MockClient extends Mock implements http.Client {}

main() {
  Uri latestNewsUri = ApiService.rebuildUrl(WebAddress.newsApiBaseUrl,
      WebAddress.newsLatest, {'q': 'Bitcoin', 'apiKey': APIKeys.newsAPI});
  group('getData', () {
    test('returns a Post if the http call completes successfully', () async {
      final client = MockClient();

      when(client.get(latestNewsUri)).thenAnswer((realInvocation) async =>
          http.Response('{"status":"200","totalResults":500}', 200));
      expect(await ApiService.getData(client, latestNewsUri), isA<NewsModel>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      when(client.get(latestNewsUri))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(ApiService.getData(client, latestNewsUri), throwsException);
    });
  });
}
