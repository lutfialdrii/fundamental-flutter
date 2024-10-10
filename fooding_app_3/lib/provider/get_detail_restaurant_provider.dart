import 'package:flutter/foundation.dart';
import 'package:fooding_final_app/data/api/api_service.dart';
import 'package:fooding_final_app/data/model/get_detail_restaurant_response.dart';

import 'get_restaurants_provider.dart';

class GetDetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  GetDetailRestaurantProvider({
    required this.apiService,
    required this.id,
  }) {
    _fetchDetailRestaurants();
  }

  // Initialize Variable
  late DetailRestaurant _detailRestaurant;
  late ResultState _state;
  String _message = '';

  DetailRestaurant get detailRestaurant => _detailRestaurant;
  String get message => _message;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getDetailRestaurant(id);
      if (response.error) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Something went wrong! ${response.message}';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _detailRestaurant = response.restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Something went wrong! $e';
    }
  }
}
