import 'package:twitter_clone/app/data/models/auth_request_status_model.dart';
import 'package:twitter_clone/app/data/source/auth_remote_data_source.dart';
import 'package:twitter_clone/app/domain/repository/base_authentication_repository.dart';

class AuthenticationRepository extends BaseAuthenticationRepository {
  final BaseAuthenticationDataSource baseAuthenticationDataSource;

  AuthenticationRepository({ required this.baseAuthenticationDataSource});

  @override
  Future<AuthRequestStatus> createAccount(String email, String password) async {
    return await baseAuthenticationDataSource.createAccount(email, password);
  }
}