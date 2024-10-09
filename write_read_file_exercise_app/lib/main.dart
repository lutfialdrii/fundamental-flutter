import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Write Read App',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: MyHomePage(),
    );
  }

  
}
