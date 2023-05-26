import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/core/utils/user_preferences.dart';

import '../models/login_request_status_model.dart';

abstract class BaseLoginDataSource {
  Future<LoginRequestStatus> logIn(String email, String password);
}

class LoginDataSource extends BaseLoginDataSource {
  @override
  Future<LoginRequestStatus> logIn(String email, String password) async {
    try {
      UserCredential response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      UserPreferences.setUserUID(response.user?.uid);
      return new LoginRequestStatus(status: 'success', code: 0);
    } on FirebaseAuthException catch (e) {
      return new LoginRequestStatus(status: e.message!, code: 1);
    }
  }

}