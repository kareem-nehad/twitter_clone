import 'package:twitter_clone/app/data/models/auth_request_status_model.dart';
import 'package:twitter_clone/app/domain/repository/base_authentication_repository.dart';

class CreateAccountUsecase {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  CreateAccountUsecase(this.baseAuthenticationRepository);

  Future<AuthRequestStatus> execute(String email, String password) async {
    return await baseAuthenticationRepository.createAccount(email, password);
  }
}