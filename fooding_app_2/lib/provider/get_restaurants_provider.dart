import 'package:flutter/foundation.dart';
import 'package:fooding_http_app/data/api/api_service.dart';
import 'package:fooding_http_app/data/model/get_restaurants_response.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantsProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  // Initialize Variable
  late List<Restaurant> _restaurants;
  late ResultState _state;
  String _message = '';

  List<Restaurant> get restaurants => _restaurants;
  String get message => _message;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.getListRestaurants();
      if (restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data!';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurants = restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Something went wrong! $e';
    }
  }
}
