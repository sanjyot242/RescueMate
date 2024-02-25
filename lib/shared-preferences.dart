import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setEmergencyContact(String key, String value) async {
    await _preferences.setString(key, value);
  }

  static Set<String> getAllKeys() {
    Set<String> keys = _preferences.getKeys();
    return keys;
  }
}