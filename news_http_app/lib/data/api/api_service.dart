import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_http_app/data/model/article_result.dart';

class ApiService {
  static const _baseUrl = 'https://newsapi.org/v2/';
  static const _apiKey = '98d3b5db100846ec9568551c29c8a2df';
  static const _category = 'business';

  Future<ArticlesResult> topHeadlines() async {
    final response = await http.get(Uri.parse(
        '${_baseUrl}top-headlines?country=us&category=$_category&apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
