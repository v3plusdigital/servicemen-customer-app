import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  Future<void> setStringValue(String key, String value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  Future<String?> getStringValue(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  Future<void> clear() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
