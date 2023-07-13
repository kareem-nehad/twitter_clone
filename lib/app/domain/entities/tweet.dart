import 'package:equatable/equatable.dart';

class TweetObject extends Equatable {
  final String userName;
  final String handle;
  final String content;
  final String profilePicture;

  TweetObject(this.userName, this.handle, this.content, this.profilePicture);


  @override
  List<Object> get props => [userName, handle, content, profilePicture];
}