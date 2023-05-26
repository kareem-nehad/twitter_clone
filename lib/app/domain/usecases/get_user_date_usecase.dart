import 'package:twitter_clone/app/domain/repository/base_user_repository.dart';

import '../entities/user.dart';

class GetUserData {
  final BaseUserRepository baseUserRepository;

  GetUserData(this.baseUserRepository);

  Future<User> execute() async{
    return await baseUserRepository.getUserData();
  }
}