import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:http/http.dart' as http;
import '../data/api/api_service.dart';
import '../main.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService(client: http.Client()).getListRestaurants();
    final randomRestaurant = result[Random().nextInt(result.length)];
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, randomRestaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
