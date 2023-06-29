import 'package:equatable/equatable.dart';

class TweetRequestStatus extends Equatable {
  final String status;
  final int code;

  TweetRequestStatus({required this.status, required this.code});

  @override
  List<Object> get props => [status, code];
}