import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:news_bookmark_app/common/navigation.dart';
import 'package:news_bookmark_app/data/api/api_service.dart';
import 'package:news_bookmark_app/helper/preferences_helper.dart';
import 'package:news_bookmark_app/provider/news_provider.dart';
import 'package:news_bookmark_app/provider/preferences_provider.dart';
import 'package:news_bookmark_app/provider/scheduling_provider.dart';
import 'package:news_bookmark_app/utils/background_service.dart';
import 'package:news_bookmark_app/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/article_web_view.dart';
import 'data/model/article_result.dart';
import 'ui/article_detail_page.dart';
import 'ui/home_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return MaterialApp(
          title: 'News App',
          // theme: ThemeData(
          //   colorScheme: Theme.of(context).colorScheme.copyWith(
          //         primary: primaryColor,
          //         onPrimary: Colors.black,
          //         secondary: secondaryColor,
          //       ),
          //   textTheme: myTextTheme,
          //   appBarTheme: const AppBarTheme(elevation: 0),
          //   elevatedButtonTheme: ElevatedButtonThemeData(
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: secondaryColor,
          //         foregroundColor: Colors.white,
          //         textStyle: const TextStyle(),
          //         shape: const RoundedRectangleBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(0)))),
          //   ),
          // ),
          theme: provider.themeData,
          builder: (context, child) {
            return CupertinoTheme(
              data: CupertinoThemeData(
                brightness:
                    provider.isDarkTheme ? Brightness.dark : Brightness.light,
              ),
              child: Material(
                child: child,
              ),
            );
          },
          initialRoute: HomePage.routeName,
          navigatorKey: navigatorKey,
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            ArticleDetailPage.routeName: (context) => ArticleDetailPage(
                  article:
                      ModalRoute.of(context)?.settings.arguments as Article,
                ),
            ArticleWebView.routeName: (context) => ArticleWebView(
                  url: ModalRoute.of(context)?.settings.arguments as String,
                )
          },
        );
      }),
    );
  }
}
