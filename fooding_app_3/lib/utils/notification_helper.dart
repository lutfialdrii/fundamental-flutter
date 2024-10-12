import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fooding_final_app/data/model/get_restaurants_response.dart';
import 'package:rxdart/rxdart.dart';

import '../common/navigation.dart';

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
    Restaurant restaurant,
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

    var titleNotification = '<b>Cek Resto Favorite mu yuk!</b>';
    var titleNews = restaurant.name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleNews,
      platformChannelSpecifics,
      payload: jsonEncode(restaurant.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectedNotificationSubject.stream.listen(
      (String payload) async {
        var data = Restaurant.fromJson(json.decode(payload));
        Navigation.intentWithData(route, data);
      },
    );
  }
}
