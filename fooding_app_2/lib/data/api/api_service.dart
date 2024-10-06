import 'package:fooding_http_app/data/model/get_restaurants_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  // Get List Restaurants
  Future<List<Restaurant>> getListRestaurants() async {
    final String url = '$_baseUrl/list';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final rawData = GetRestaurantsResponse.fromJson(response.body);
      final data = rawData.restaurants;
      return data;
    } else {
      throw Exception('Failed to load list restaurants');
    }
  }
}
