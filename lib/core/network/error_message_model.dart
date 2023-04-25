import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String errorCode;
  final String errorMessage;

  const ErrorMessageModel(
      {required this.errorMessage, required this.errorCode});

  @override
  List<Object> get props => [errorCode, errorMessage];
}
