import 'package:equatable/equatable.dart';

class TweetObject extends Equatable {
  final String userName;
  final String handle;
  final String content;

  TweetObject(this.userName, this.handle, this.content);

  @override
  List<Object> get props => [userName, handle, content];
}