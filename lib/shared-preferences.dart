import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setEmergencyContact(String key, String value) async {
    await _preferences.setString(key, value);
  }

  static Future setEmergencyContactCount(String key, String value) async {
    await _preferences.setString(key, value);
  }
  
  static String? getEmergencyContactCount(String key) {
    return _preferences.getString(key);
  }

  static String? getEmergencyContact(String key) {
    return _preferences.getString(key);
  }

  static Future setLatitude(String key, String value) async {
    await _preferences.setString(key, value);
  }

  static String? getLatitude(String key) {
    return _preferences.getString(key);
  }

  static Future setLongtitude(String key, String value) async {
    await _preferences.setString(key, value);
  }

  static String? getLongtitude(String key) {
    return _preferences.getString(key);
  }

  static Future setHospitalData(String key, String value) async {
    await _preferences.setString(key, value);
  }

  static String? getHospitalData(String key) {
    return _preferences.getString(key);
  }

  static Future setPharmacyData(String key, String value) async {
    await _preferences.setString(key, value);
  }

  static String? getPharmacyData(String key) {
    return _preferences.getString(key);
  }

  static Set<String> getAllKeys() {
    Set<String> keys = _preferences.getKeys();
    return keys;
  }

  
}