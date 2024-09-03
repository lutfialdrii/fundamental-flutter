import 'package:flutter/material.dart';
import 'package:nav_routing_app/another_screen.dart';
import 'package:nav_routing_app/first_screen.dart';
import 'package:nav_routing_app/replacement_screen.dart';
import 'package:nav_routing_app/return_data_screen.dart';
import 'package:nav_routing_app/second_screen.dart';
import 'package:nav_routing_app/second_screen_with_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        '/secondScreen': (context) => const SecondScreen(),
        '/secondScreenWithData': (context) => SecondScreenWithData(
            data: ModalRoute.of(context)?.settings.arguments as String),
        '/returnDataScreen': (context) => const ReturnDataScreen(),
        '/replacementScreen': (context) => const ReplacementScreen(),
        '/anotherScreen': (context) => const AnotherScreen(),
      },
      // home: const FirstScreen(),
    );
  }
}
