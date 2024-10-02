import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:simple_android_alarm_manager/utils/background_service.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BackgroundService _service = BackgroundService();

  @override
  void initState() {
    super.initState();
    port.listen(
      (_) async => await _service.someTask(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                await AndroidAlarmManager.oneShot(
                  const Duration(seconds: 3),
                  1,
                  BackgroundService.callback,
                  exact: true,
                  wakeup: true,
                );
              },
              child: const Text('Alarm with Delayed (once)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await AndroidAlarmManager.oneShotAt(
                  DateTime.now().add(const Duration(seconds: 5)),
                  2,
                  BackgroundService.callback,
                  exact: true,
                  wakeup: true,
                );
              },
              child: const Text('Alarm with Date Time (once)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await AndroidAlarmManager.periodic(
                  Duration(minutes: 1),
                  3,
                  BackgroundService.callback,
                  startAt: DateTime.now(),
                  exact: true,
                  wakeup: true,
                );
              },
              child: const Text('Alarm with Periodic'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await AndroidAlarmManager.cancel(3);
              },
              child: const Text('Cancel Alarm by id'),
            )
          ],
        ),
      ),
    );
  }
}
