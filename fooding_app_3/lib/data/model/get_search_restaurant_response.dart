import 'dart:convert';

import 'get_restaurants_response.dart';

class GetSearchRestaurantResponse {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  GetSearchRestaurantResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory GetSearchRestaurantResponse.fromJson(String str) =>
      GetSearchRestaurantResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSearchRestaurantResponse.fromMap(Map<String, dynamic> json) =>
      GetSearchRestaurantResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toMap())),
      };
}
