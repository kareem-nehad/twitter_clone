import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/app/data/models/auth_request_status_model.dart';

abstract class BaseAuthenticationDataSource {
  Future<AuthRequestStatus> createAccount(String email, String password, String username);
}

class AuthenticationDataSource extends BaseAuthenticationDataSource {
  @override
  Future<AuthRequestStatus> createAccount(String email, String password, String username) async {
    try {
      UserCredential response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseFirestore.instance.collection('users').doc(response.user?.uid).set({
        'uid': response.user?.uid,
        'username': username
      },SetOptions(merge: true));
      FirebaseFirestore.instance.collection('users').doc(response.user?.uid).collection('tweets').doc().set(
          {});
      return AuthRequestStatus(status: 'success', code: 0);
    } on FirebaseAuthException catch (e) {
      return AuthRequestStatus(status: e.message!, code: 1);
    }
  }
}
