import 'package:equatable/equatable.dart';

class Tweet extends Equatable {
  final String userName;
  final String handle;
  final String content;

  Tweet(this.userName, this.handle, this.content);

  @override
  List<Object> get props => [userName, handle, content];
}