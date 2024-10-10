import 'package:flutter/foundation.dart';
import 'package:fooding_final_app/data/api/api_service.dart';
import '../data/model/get_restaurants_response.dart';
import '../utils/result_state.dart';

class GetSearchRestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;
  final String query;
  GetSearchRestaurantsProvider({
    required this.apiService,
    required this.query,
  }) {
    _fetchSearchRestaurants();
  }

  // Initialize Variable
  late List<Restaurant> _resultRestaurants;
  late ResultState _state;
  String _message = '';

  List<Restaurant> get result => _resultRestaurants;
  String get message => _message;
  ResultState get state => _state;

  Future<dynamic> _fetchSearchRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.searchRestaurants(query);
      if (restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data!';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _resultRestaurants = restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Something went wrong! $e';
    }
  }
}
