import 'package:flutter/material.dart';
import 'package:fooding_final_app/common/styles.dart';
import 'package:fooding_final_app/provider/get_restaurants_provider.dart';
import 'package:fooding_final_app/ui/restaurant_search_page.dart';
import 'package:fooding_final_app/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';
import '../data/model/get_restaurants_response.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Foodish👋',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Ready to visit a resto?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                _buildList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(context: context, delegate: RestaurantSearchPage());
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantsProvider>(
      builder: (context, value, child) {
        if (value.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: secondaryColor,
            ),
          );
        } else if (value.state == ResultState.hasData) {
          final listRestaurants = value.restaurants;
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
            child: Material(
              child: Text('Tidak ada data Restaurant'),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text('Terjadi Kesalahan, perikasi koneksi internet anda!'),
            ),
          );
        }
      },
    );
  }
}
