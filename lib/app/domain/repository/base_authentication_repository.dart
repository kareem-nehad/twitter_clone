import 'package:twitter_clone/app/data/models/auth_request_status_model.dart';

abstract class BaseAuthenticationRepository {
  Future<AuthRequestStatus> createAccount(String email, String password);
}