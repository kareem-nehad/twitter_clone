part of 'create_account_bloc.dart';

@immutable
abstract class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();

  @override
  List<Object> get props => [];
}

class CreateAccount extends CreateAccountEvent {
  final String email;
  final String password;
  final String username;

  const CreateAccount({required this.email, required this.password, required this.username});
}

class CreateAccountWithImage extends CreateAccountEvent {
  final String email;
  final String password;
  final String username;
  final String imageName;

  const CreateAccountWithImage({required this.email, required this.password, required this.username, required this.imageName});
}
