import 'package:equatable/equatable.dart';

class LikeRequestStatus extends Equatable {
  final String status;
  final int code;

  LikeRequestStatus({required this.status, required this.code});

  @override
  List<Object> get props => [status, code];
}