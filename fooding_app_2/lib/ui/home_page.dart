import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooding_http_app/common/styles.dart';
import 'package:fooding_http_app/ui/restaurant_list_page.dart';
import 'package:fooding_http_app/ui/setting_page.dart';
import 'package:fooding_http_app/widgets/platform_widget.dart';
import 'dart:io';

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
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
        label: 'Settings')
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: _bottomNavbarItems,
          selectedItemColor: secondaryColor,
          onTap: (value) {
            setState(() {
              _bottomNavIndex = value;
            });
          },
        ),
        body: _bottomNavIndex == 0
            ? const RestaurantListPage()
            : const SettingPage());
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavbarItems,
        activeColor: secondaryColor,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 1:
            return const SettingPage();
          default:
            return const RestaurantListPage();
        }
      },
    );
  }
}
