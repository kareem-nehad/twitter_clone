import 'package:twitter_clone/app/data/source/user_data_source.dart';
import 'package:twitter_clone/app/domain/entities/user.dart';
import 'package:twitter_clone/app/domain/repository/base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final BaseUserRemoteDataSource baseUserRemoteDataSource;

  UserRepository({
    required this.baseUserRemoteDataSource,
  });

  @override
  Future<User> getUserData() async {
    return await baseUserRemoteDataSource.getUserData();
  }
}
