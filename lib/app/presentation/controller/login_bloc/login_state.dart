part of 'login_bloc.dart';

enum LoginStatus { success, failure, loading, awaiting }

class LoginState extends Equatable {
  final String email;
  final String password;
  final String message;
  final LoginStatus status;

  LoginState({
    this.email = '',
    this.password = '',
    this.message = '',
    this.status = LoginStatus.awaiting,
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? message,
    LoginStatus? status
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, message, status];

}
