import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setUserUID (String? uid) async {
    await _preferences?.setString('uid', uid!);
  }

  static String? getUserUID () {
    return _preferences?.getString('uid');
  }
}