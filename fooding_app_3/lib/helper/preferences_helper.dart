import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyReminderKey = 'DAILY_REMINDER';

  Future<bool> get isDailyReminderOn async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyReminderKey) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyReminderKey, value);
  }
}
