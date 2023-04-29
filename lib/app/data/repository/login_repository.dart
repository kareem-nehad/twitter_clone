import 'package:twitter_clone/app/data/models/login_request_status_model.dart';
import 'package:twitter_clone/app/data/source/login_remote_data_source.dart';
import 'package:twitter_clone/app/domain/repository/base_login_repository.dart';

class LoginRepository extends BaseLoginRepository{
  final BaseLoginDataSource baseLoginDataSource;


  LoginRepository({required this.baseLoginDataSource});

  @override
  Future<LoginRequestStatus> logIn(String email, String password) async {
   return await baseLoginDataSource.logIn(email, password);
  }

}