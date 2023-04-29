import '../../data/models/login_request_status_model.dart';

abstract class BaseLoginRepository {
  Future<LoginRequestStatus> logIn(String email, String password);
}