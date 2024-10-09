import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:news_bookmark_app/common/navigation.dart';
import 'package:news_bookmark_app/data/model/article_result.dart';
import 'package:rxdart/rxdart.dart';

final selectedNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializeSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializeSettingsIos = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializitaionSettings = InitializationSettings(
      android: initializeSettingsAndroid,
      iOS: initializeSettingsIos,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializitaionSettings,
      onDidReceiveNotificationResponse: (details) async {
        final payload = details.payload;

        if (payload != null) {
          print('notification payload: ' + payload);
        }

        selectedNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    ArticlesResult articles,
  ) async {
    var channelId = '1';
    var channelName = 'channel_01';
    var channelDescription = 'dicoding_news_channel';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'Ticker',
      styleInformation: const DefaultStyleInformation(
        true,
        true,
      ),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = '<b>Headline News</b>';
    var titleNews = articles.articles[0].title;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleNews,
      platformChannelSpecifics,
      payload: jsonEncode(articles.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectedNotificationSubject.stream.listen(
      (String payload) async {
        var data = ArticlesResult.fromJson(json.decode(payload));
        var article = data.articles[0];
        Navigation.intentWithData(route, article);
      },
    );
  }
}
