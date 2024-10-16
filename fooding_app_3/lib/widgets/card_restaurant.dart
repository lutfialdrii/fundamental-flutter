import 'package:flutter/material.dart';
import 'package:fooding_final_app/provider/database_provider.dart';
import 'package:provider/provider.dart';
import '../common/styles.dart';
import '../data/model/get_restaurants_response.dart';
import '../ui/detail_restaurant_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardRestaurant({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        child: Consumer<DatabaseProvider>(
          builder: (context, provider, child) {
            return FutureBuilder<bool>(
              future: provider.isFavorited(restaurant.id),
              builder: (context, snapshot) {
                var isFavorited = snapshot.data ?? false;
                return ListTile(
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
                    tag:
                        'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                      width: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.error),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    restaurant.name,
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
                            restaurant.city,
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
                            restaurant.rating.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: secondaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      isFavorited
                          ? provider.removeFavorite(restaurant.id)
                          : provider.addFavorite(restaurant);
                    },
                    icon: Icon(
                      isFavorited
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: secondaryColor,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
