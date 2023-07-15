import 'package:twitter_clone/app/data/source/full_user_data_source.dart';
import 'package:twitter_clone/app/domain/entities/full_user_data.dart';
import 'package:twitter_clone/app/domain/repository/base_full_user_repository.dart';

class FullUserRepository extends BaseFullUserRepository {
  final BaseFullUserDataSource baseFullUserDataSource;

  FullUserRepository({required this.baseFullUserDataSource});

  @override
  Future<FullUserData> getFullUserData(String uid) async {
   return await baseFullUserDataSource.getFullUserData(uid);
  }
}