import '../entities/user.dart';

abstract class BaseUserRepository{
  Future<User> getUserData();
}