import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

List items = ['number', 'address', 'name'];

Future<Map> initSettingsData() async {
  await Hive.openBox("settings");

  Box box = Hive.box("settings");

  Map answer = {};

  for (var item in items) {
    answer[item] = box.get(item);
    if (box.get(item) == null) {
      answer[item] = '';
    }
  }

  return answer;
}

class SettingsProvider with ChangeNotifier {
  Map settings;
  SettingsProvider({required this.settings});

  void updateSettings(Map newSettings) {
    settings = newSettings;
    Box box = Hive.box('settings');

    for (var i in items) {
      box.put(i, settings[i]);
    }
    notifyListeners();
  }
}
