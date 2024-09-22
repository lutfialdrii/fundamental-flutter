import 'package:flutter/material.dart';
import 'package:fooding_app/common/styles.dart';
import 'package:fooding_app/data/model/restaurant.dart';
import 'package:fooding_app/ui/detail_restaurant_page.dart';

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
                _buildList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<String> _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final Restaurant rawData = Restaurant.fromJson(snapshot.data!);
        final List<RestaurantElement> listRestaurants = rawData.restaurants!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listRestaurants.length,
          itemBuilder: (context, index) {
            final RestaurantElement restaurant = listRestaurants[index];
            return _cardResto(context, restaurant);
          },
        );
      },
    );
  }

  Card _cardResto(BuildContext context, RestaurantElement restaurant) {
    return Card(
      child: Material(
        child: ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DetailRestaurantPage(
                  restaurant: restaurant,
                );
              },
            ));
          },
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: Hero(
            tag: restaurant.pictureId!,
            child: Image.network(
              restaurant.pictureId!,
              width: 100,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.error),
                );
              },
            ),
          ),
          title: Text(
            restaurant.name!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    restaurant.city!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    size: 13,
                    color: secondaryColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    restaurant.rating!.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: secondaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
