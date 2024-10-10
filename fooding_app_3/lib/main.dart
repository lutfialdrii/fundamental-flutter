import 'package:flutter/material.dart';
import 'package:fooding_final_app/ui/splash_screen.dart';

import 'common/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fooding',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.black,
                secondary: secondaryColor,
              ),
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(
              backgroundColor: secondaryColor,
              titleTextStyle: TextStyle(color: primaryColor),
              iconTheme: IconThemeData(color: primaryColor)),
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
