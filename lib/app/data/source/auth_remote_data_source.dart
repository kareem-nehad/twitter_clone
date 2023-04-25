import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/app/data/models/auth_request_status_model.dart';
import 'package:twitter_clone/core/error/exception.dart';
import 'package:twitter_clone/core/network/error_message_model.dart';

abstract class BaseAuthenticationDataSource {
  Future<AuthRequestStatus> createAccount(String email, String password);
}

class AuthenticationDataSource extends BaseAuthenticationDataSource {
  @override
  Future<AuthRequestStatus> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return new AuthRequestStatus(status: 'Success', code: 0);
    } on FirebaseAuthException catch (e) {
      return new AuthRequestStatus(status: e.message!, code: 1);
    }
  }
}
