import 'package:flutter/foundation.dart';
import 'package:news_provider_app/data/api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;

  NewsProvider({required this.apiService}) {

  }
}
