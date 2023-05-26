import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:twitter_clone/core/utils/user_preferences.dart';

import '../../domain/entities/user.dart';

abstract class BaseUserRemoteDataSource {
  Future<User> getUserData();
}

class UserRemoteDataSource extends BaseUserRemoteDataSource {
  @override
  Future<User> getUserData() async {
    ValueNotifier<String> userName = ValueNotifier('');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserPreferences.getUserUID())
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      userName.value = data!['username'];
    });

    return User(username: userName.value);
  }
}
