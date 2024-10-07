import 'package:fooding_http_app/data/model/get_detail_restaurant_response.dart';
import 'package:fooding_http_app/data/model/get_restaurants_response.dart';
import 'package:fooding_http_app/data/model/get_search_restaurant_response.dart'
    as search;
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  // Get List Restaurants
  Future<List<Restaurant>> getListRestaurants() async {
    const String url = '$_baseUrl/list';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final rawData = GetRestaurantsResponse.fromJson(response.body);
      final data = rawData.restaurants;
      return data;
    } else {
      throw Exception('Failed to load list restaurants');
    }
  }

  // Get Detail Restaurant
  Future<GetDetailRestaurantResponse> getDetailRestaurant(String id) async {
    String url = '$_baseUrl/detail/$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = GetDetailRestaurantResponse.fromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  // Search Restaurant
  Future<List<Restaurant>> searchRestaurants(String query) async {
    String url = '$_baseUrl/search?q=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final rawData =
          search.GetSearchRestaurantResponse.fromJson(response.body);
      final data = rawData.restaurants;
      return data;
    } else {
      throw Exception('Failed to get result');
    }
  }
}
