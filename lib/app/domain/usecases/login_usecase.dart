import 'package:twitter_clone/app/domain/repository/base_login_repository.dart';

import '../../data/models/login_request_status_model.dart';

class LoginUsecase {
  final BaseLoginRepository baseLoginRepository;

  LoginUsecase(this.baseLoginRepository);

  Future<LoginRequestStatus> execute(String email, String password) async {
    return await baseLoginRepository.logIn(email, password);
  }
}