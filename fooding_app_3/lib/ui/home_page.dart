import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooding_final_app/common/styles.dart';
import 'package:fooding_final_app/ui/restaurant_list_page.dart';
import 'package:fooding_final_app/ui/setting_page.dart';
import 'package:fooding_final_app/widgets/platform_widget.dart';
import 'dart:io';

import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  final List<BottomNavigationBarItem> _bottomNavbarItems = [
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
        label: 'Home'),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Platform.isIOS ? CupertinoIcons.settings : Icons.settings,
        ),
        label: 'Settings')
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavbarItems,
        selectedItemColor: secondaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          setState(() {
            _bottomNavIndex = value;
          });
        },
      ),
      body: _listWidget[_bottomNavIndex],
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavbarItems,
        activeColor: secondaryColor,
      ),
      tabBuilder: (context, index) {
        return _listWidget[_bottomNavIndex];
      },
    );
  }

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const FavoritesPage(),
    const SettingPage(),
  ];
}
