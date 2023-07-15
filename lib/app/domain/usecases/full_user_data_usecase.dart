import '../entities/full_user_data.dart';
import '../repository/base_full_user_repository.dart';

class GetFullUserData {
  final BaseFullUserRepository baseFullUserRepository;

  GetFullUserData(this.baseFullUserRepository);

  Future<FullUserData> execute(String uid) async {
    return await baseFullUserRepository.getFullUserData(uid);
  }
}