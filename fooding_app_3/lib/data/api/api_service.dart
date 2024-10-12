import 'package:fooding_final_app/data/model/get_detail_restaurant_response.dart';
import 'package:fooding_final_app/data/model/get_restaurants_response.dart';
import 'package:fooding_final_app/data/model/get_search_restaurant_response.dart'
    as search;
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';
  final http.Client client;

  // Constructor untuk menerima client sebagai parameter
  ApiService({required this.client});

  // Get List Restaurants
  Future<List<Restaurant>> getListRestaurants() async {
    try {
      const String url = '$baseUrl/list';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final rawData = GetRestaurantsResponse.fromJson(response.body);
        final data = rawData.restaurants;
        return data;
      } else {
        throw Exception('Failed to load list restaurants');
      }
    } catch (e) {
      throw Exception('Somethimg went wrong $e');
    }
  }

  // Get Detail Restaurant
  Future<GetDetailRestaurantResponse> getDetailRestaurant(String id) async {
    try {
      String url = '$baseUrl/detail/$id';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = GetDetailRestaurantResponse.fromJson(response.body);
        return data;
      } else {
        throw Exception('Failed to load detail restaurant');
      }
    } catch (e) {
      throw Exception('Somethimg went wrong $e');
    }
  }

  // Search Restaurant
  Future<List<Restaurant>> searchRestaurants(String query) async {
    try {
      String url = '$baseUrl/search?q=$query';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final rawData =
            search.GetSearchRestaurantResponse.fromJson(response.body);
        final data = rawData.restaurants;
        return data;
      } else {
        throw Exception('Failed to get result');
      }
    } catch (e) {
      throw Exception('Somethimg went wrong $e');
    }
  }
}
