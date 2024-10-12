import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fooding_final_app/common/navigation.dart';
import 'package:fooding_final_app/data/api/api_service.dart';
import 'package:fooding_final_app/data/db/database_helper.dart';
import 'package:fooding_final_app/helper/preferences_helper.dart';
import 'package:fooding_final_app/provider/database_provider.dart';
import 'package:fooding_final_app/provider/get_restaurants_provider.dart';
import 'package:fooding_final_app/provider/preferences_provider.dart';
import 'package:fooding_final_app/provider/scheduling_provider.dart';
import 'package:fooding_final_app/ui/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'common/styles.dart';
import 'utils/background_service.dart';
import 'utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantsProvider(
              apiService: ApiService(client: http.Client())),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (context) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance())),
        ),
      ],
      child: MaterialApp(
          navigatorKey: navigatorKey,
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
          home: const SplashScreen()),
    );
  }
}
