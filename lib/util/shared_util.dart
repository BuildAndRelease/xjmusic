import 'package:shared_preferences/shared_preferences.dart';

class SharedUtil {
  static final SharedUtil _singleton = SharedUtil._internal();

  static SharedUtil get instance => _singleton;

  factory SharedUtil() {
    return _singleton;
  }

  SharedUtil._internal();

  Future saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future saveDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  Future saveBoolean(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future saveStringList(String key, List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, list);
  }

  Future saveListWithToken(String key, List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Keys.token);
    await prefs.setStringList(key + token, list);
  }

  //-----------------------------------------------------get----------------------------------------------------

  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<int> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<double> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  Future<bool> getBoolean(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<List<String>> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  Future<List<String>> getListWithToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Keys.token);
    return prefs.getStringList(key + token);
  }
}

class Keys {
  static const String token = "token";
  static const String needUpdate = "need_update";
  static const String updatePeriod = "update_period";
  static const String fanBook = "fan_book";
  static const String accessKey = "access_key";
}
