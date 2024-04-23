import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';

class SharedPref {
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static Future<bool> contains({required SharedPrefKey key}) async {
    return _prefsInstance != null
        ? _prefsInstance!.getKeys().contains(key.toString())
        : false;
  }

  static Future<String?> getString({required SharedPrefKey key}) async {
    return _prefsInstance != null
        ? _prefsInstance!.getString(key.toString())
        : null;
  }

  static String? getStringValue({required SharedPrefKey key}) {
    return _prefsInstance != null
        ? _prefsInstance!.getString(key.toString())
        : null;
  }

  static Future<bool> setString(
      {required SharedPrefKey key, required String? value}) async {
    return _prefsInstance != null && value != null
        ? _prefsInstance!.setString(key.toString(), value)
        : Future.value(false);
  }

  static Future<bool> removeString({required SharedPrefKey key}) async {
    return _prefsInstance != null && await contains(key: key)
        ? _prefsInstance!.remove(key.toString())
        : Future.value(false);
  }
}
