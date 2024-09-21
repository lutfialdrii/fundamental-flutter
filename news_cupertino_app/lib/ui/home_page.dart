import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_cupertino_app/ui/article_list_page.dart';
import 'package:news_cupertino_app/ui/settings_page.dart';
import 'package:news_cupertino_app/widgets/platform_widget.dart';

import '../styles.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
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
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.news : Icons.public,
      ),
      label: 'Headline',
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: 'Settings',
    ),
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body:
          _bottomNavIndex == 0 ? const ArticleListPage() : const SettingsPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavbarItems,
        selectedItemColor: secondaryColor,
        onTap: (value) {
          setState(() {
            _bottomNavIndex = value;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: secondaryColor,
        items: _bottomNavbarItems,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 1:
            return const SettingsPage();
          default:
            return const ArticleListPage();
        }
      },
    );
  }
}
