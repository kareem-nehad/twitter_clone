import 'dart:async';

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

  static Future setUserEmail (String? email) async {
    await _preferences?.setString('email', email!);
  }

  static String? getUserEmail () {
    return _preferences?.getString('email');
  }

  static Future clearUserEmail () async {
    await _preferences?.remove('email');
  }

  static Future setUserPassword (String? password) async {
    await _preferences?.setString('password', password!);
  }

  static String? getUserPassword () {
    return _preferences?.getString('password');
  }

  static Future clearUserPassword () async {
    await _preferences?.remove('password');
  }

  static Future setUserName (String? username) async {
    await _preferences?.setString('username', username!);
  }

  static String? getUserName() {
    return _preferences?.getString('username');
  }

  static Future setUserImage(String? userImage) async {
    await _preferences?.setString('userImage', userImage!);
  }

  static String? getUserImage() {
    return _preferences?.getString('userImage');
  }
}