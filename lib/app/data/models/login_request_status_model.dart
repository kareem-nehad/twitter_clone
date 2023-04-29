import 'package:equatable/equatable.dart';

class LoginRequestStatus extends Equatable {
  final String status;
  final int code;


  LoginRequestStatus({required this.status, required this.code});

  @override
  List<Object> get props => [status, code];
}