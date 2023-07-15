import '../entities/full_user_data.dart';

abstract class BaseFullUserRepository {
  Future<FullUserData> getFullUserData(String uid);
}