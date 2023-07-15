import 'package:equatable/equatable.dart';
import 'package:twitter_clone/app/domain/entities/tweet.dart';

class FullUserData extends Equatable {
  final String username;
  final String uid;
  final String userImage;
  final List<TweetObject> tweets;

  const FullUserData({required this.username, required this.uid, required this.userImage, required this.tweets});

  @override
  List<Object> get props => [username, uid, userImage, tweets];
}