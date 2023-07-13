import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_clone/core/utils/user_preferences.dart';

import '../../domain/entities/tweet.dart';
import '../models/tweet_status.dart';

abstract class BaseTweetDataSource {
  Future<TweetRequestStatus> tweet(TweetObject tweet);
}

class TweetDataSource extends BaseTweetDataSource {
  @override
  Future<TweetRequestStatus> tweet(TweetObject tweet) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserPreferences.getUserUID())
        .collection('tweets')
        .add({
      'content': tweet.content,
      'uid': tweet.handle,
      'username': tweet.userName,
      'image': UserPreferences.getUserImage()!
    });
    return TweetRequestStatus(status: 'Success', code: 0);
  }

}