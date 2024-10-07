import 'package:flutter/material.dart';
import 'package:fooding_http_app/common/styles.dart';
import 'package:fooding_http_app/data/api/api_service.dart';
import 'package:fooding_http_app/provider/get_search_restaurants_provider.dart';
import 'package:fooding_http_app/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';
import '../data/model/get_restaurants_response.dart';

class RestaurantSearchPage extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            '';
          },
          icon: const Icon(Icons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ChangeNotifierProvider<GetSearchRestaurantsProvider>(
      create: (context) => GetSearchRestaurantsProvider(
        apiService: ApiService(),
        query: query,
      ),
      child: Consumer<GetSearchRestaurantsProvider>(
        builder: (context, value, child) {
          if (value.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            );
          } else if (value.state == ResultState.hasData) {
            final listRestaurants = value.result;
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listRestaurants.length,
                itemBuilder: (context, index) {
                  final Restaurant restaurant = listRestaurants[index];
                  return CardRestaurant(restaurant: restaurant);
                });
          } else if (value.state == ResultState.noData) {
            return const Center(
              child: Text('Tidak ada data restaurant'),
            );
          } else if (value.state == ResultState.error) {
            return const Center(
              child: Text('Terjadi Kesalahan!, perikasi koneksi internet anda!'),
            );
          } else {
            return const Center(
              child: Text('Terjadi Kesalahan!'),
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Search restaurant'));
  }
}
