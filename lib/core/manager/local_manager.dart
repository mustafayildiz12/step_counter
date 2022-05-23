import 'package:shared_preferences/shared_preferences.dart';

import 'exception.dart';

enum SharedKeys { counter, users, dummy }

class SharedManager {
  SharedPreferences? preferences;

  SharedManager();

  void _checkPref() {
    if (preferences == null) {
      throw SharedException();
    }
  }

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> setString(SharedKeys key, String value) async {
    _checkPref();
    await preferences?.setString(key.name, value);
  }

  Future<void> saveStringList(SharedKeys key, List<String> value) async {
    _checkPref();
    await preferences?.setStringList(key.name, value);
  }

  List<String>? getStringList(SharedKeys key) {
    _checkPref();
    return preferences?.getStringList(key.name);
  }

  String? getString(SharedKeys key) {
    _checkPref();
    return preferences?.getString(key.name);
  }

  Future<bool> removeItem(SharedKeys key) async {
    _checkPref();
    return (await preferences?.remove(key.name)) ?? false;
  }
}
