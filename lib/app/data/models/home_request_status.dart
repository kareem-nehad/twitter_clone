import 'package:equatable/equatable.dart';

class HomeRequestStatus extends Equatable {
  final String status;
  final int code;


  HomeRequestStatus({required this.status, required this.code});

  @override
  List<Object> get props => [status, code];

}
