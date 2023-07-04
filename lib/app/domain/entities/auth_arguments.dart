import 'package:equatable/equatable.dart';

class AuthArguments extends Equatable {
  final String email;
  final String password;
  final String username;

  AuthArguments({
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  List<Object> get props => [email, password, username];
}
