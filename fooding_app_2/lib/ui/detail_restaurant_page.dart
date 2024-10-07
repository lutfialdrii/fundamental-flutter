import 'package:flutter/material.dart';
import 'package:fooding_http_app/common/styles.dart';
import 'package:fooding_http_app/data/api/api_service.dart';
import 'package:fooding_http_app/data/model/get_detail_restaurant_response.dart';
import 'package:fooding_http_app/provider/get_detail_restaurant_provider.dart';
import 'package:fooding_http_app/provider/get_restaurants_provider.dart';
import 'package:provider/provider.dart';
import '../data/model/get_restaurants_response.dart';

class DetailRestaurantPage extends StatelessWidget {
  final Restaurant restaurant;
  const DetailRestaurantPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GetDetailRestaurantProvider>(
      create: (context) => GetDetailRestaurantProvider(
          apiService: ApiService(), id: restaurant.id),
      child: Consumer<GetDetailRestaurantProvider>(
        builder: (BuildContext context, GetDetailRestaurantProvider value,
            Widget? child) {
          if (value.state == ResultState.loading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: secondaryColor,),
              ),
            );
          } else if (value.state == ResultState.hasData) {
            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 200,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Hero(
                          tag:
                              'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                            colorBlendMode: BlendMode.darken,
                            color: Colors.black.withOpacity(0.5),
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          restaurant.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        centerTitle: true,
                        titlePadding:
                            const EdgeInsets.only(left: 16, bottom: 16),
                      ),
                    )
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        const SizedBox(height: 4),
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
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Categories',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.detailRestaurant.categories.length,
                          itemBuilder: (context, index) {
                            Category category =
                                value.detailRestaurant.categories[index];
                            return Align(
                              alignment: Alignment.center,
                              child: Text(
                                category.name,
                                style: const TextStyle(fontSize: 12),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Divider(color: Colors.grey.withOpacity(0.4)),
                        Text(
                          'Description',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Divider(color: Colors.grey.withOpacity(0.4)),
                        const SizedBox(height: 4),
                        Text(
                          restaurant.description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Divider(color: Colors.grey.withOpacity(0.4)),
                        Text(
                          'Menus',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Divider(color: Colors.grey.withOpacity(0.4)),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Foods',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      value.detailRestaurant.menus.foods.length,
                                  itemBuilder: (context, index) {
                                    DetailRestaurant restaurant =
                                        value.detailRestaurant;
                                    return Text(
                                      restaurant.menus.foods[index].name,
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Drinks',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value
                                      .detailRestaurant.menus.drinks.length,
                                  itemBuilder: (context, index) {
                                    DetailRestaurant restaurant =
                                        value.detailRestaurant;
                                    return Text(
                                      restaurant.menus.drinks[index].name,
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                )
                              ],
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }
}
