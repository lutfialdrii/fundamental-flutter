import 'package:flutter/foundation.dart';
import 'package:fooding_final_app/helper/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  PreferencesProvider({
    required this.preferencesHelper,
  }) {
    _getDailyReminderValue();
  }

  bool _isDailyReminderOn = false;
  bool get isDailyReminderOn => _isDailyReminderOn;

  void _getDailyReminderValue() async {
    _isDailyReminderOn = await preferencesHelper.isDailyReminderOn;
    notifyListeners();
  }

  void setDailyReminder(bool value) {
    preferencesHelper.setDailyReminder(value);
    _getDailyReminderValue();
  }
}
