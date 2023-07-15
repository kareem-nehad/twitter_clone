import 'package:equatable/equatable.dart';

class TweetObject extends Equatable {
  final String userName;
  final String uID;
  final String handle;
  final String content;
  final String profilePicture;
  final String date;

  TweetObject(this.userName, this.uID, this.handle, this.content, this.profilePicture, this.date);

  @override
  List<Object> get props => [userName, uID, handle, content, profilePicture, date];
}
