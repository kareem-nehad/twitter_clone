import 'package:equatable/equatable.dart';

class AuthRequestStatus extends Equatable {
  final String status;
  final int code;


  AuthRequestStatus({required this.status, required this.code});

  @override
  List<Object> get props => [status, code];
}