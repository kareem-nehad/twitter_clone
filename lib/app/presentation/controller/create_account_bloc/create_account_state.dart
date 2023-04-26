part of 'create_account_bloc.dart';

enum AuthStatus {
  success,
  failure,
  loading,
  unauthenticated,
}

class CreateAccountState extends Equatable {
  final String email;
  final String password;
  final AuthStatus status;
  final String message;

  CreateAccountState({
    this.email = '',
    this.password = '',
    this.status = AuthStatus.unauthenticated,
    this.message = '',
  });

  CreateAccountState copyWith({
    String? email,
    String? password,
    AuthStatus? status,
    String? message
  }) {
    return CreateAccountState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [email, password, status, message];
}
