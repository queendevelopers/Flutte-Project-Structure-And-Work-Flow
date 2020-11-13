import 'package:entry_assignment/core/models/news/NewsModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Uri rebuildUrl(
      String baseUrl, unencodedPath, Map<String, String> params) {
    return Uri.https(baseUrl, unencodedPath, params);
  }

  static Future<NewsModel> getData(http.Client client,Uri uri) async {
    print(uri);
    final response = await client.get(uri);
    print('status code ${response.statusCode}');
    if (response.statusCode == 200) {
      return NewsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
