import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooding_final_app/provider/database_provider.dart';
import 'package:fooding_final_app/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

import '../common/styles.dart';
import '../data/model/get_restaurants_response.dart';
import '../utils/result_state.dart';
import '../widgets/card_restaurant.dart';

class FavoritesPage extends StatefulWidget {
  static const routeName = '/favorites_page';

  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorites",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Favorites"),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(color: secondaryColor),
          );
        } else if (provider.state == ResultState.hasData) {
          final listRestaurants = provider.favorites;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listRestaurants.length,
            itemBuilder: (context, index) {
              final Restaurant restaurant = listRestaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (provider.state == ResultState.noData) {
          return const Center(
            child: Material(
              child: Text('Anda belum memiliki Resto favorite'),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text('Terjadi Kesalahan :('),
            ),
          );
        }
      },
    );
  }
}
