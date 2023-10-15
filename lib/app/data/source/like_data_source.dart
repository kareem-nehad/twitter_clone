import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/app/domain/entities/tweet.dart';
import 'package:twitter_clone/core/utils/user_preferences.dart';

import '../models/LikeRequestStatus.dart';

abstract class BaseLikeDataSource {
  Future<LikeRequestStatus> like(TweetObject tweet);
  Future<LikeRequestStatus> unlike(TweetObject tweet);
  Future<bool> isLiked(TweetObject tweet);
  Future<List<TweetObject>> getLikedTweets();
}

class LikeDataSource extends BaseLikeDataSource {
  @override
  Future<LikeRequestStatus> like(TweetObject tweet) async {

    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserPreferences.getUserUID())
        .collection('likes')
        .add({
      'content': tweet.content,
      'uid': tweet.uID,
      'handle': tweet.handle,
      'username': tweet.userName,
      'image': tweet.profilePicture,
      'date' : getDate(),
    });

    return LikeRequestStatus(status: 'Success', code: 0);
  }

  String getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  @override
  Future<bool> isLiked(TweetObject tweet) async {
    int flag = 0;
    await FirebaseFirestore.instance.collection('users').doc(UserPreferences.getUserUID()).collection('likes').get().then(
          (value) {
        for (var data in value.docs) {
          if (data.data()['content'] == tweet.content) {
            flag = 1;
            break;
          } else {
            continue;
          }
        }
      },
    );

    if (flag == 1) {
      print('Performing Unlike');
      await unlike(tweet);
      return false;
    } else {
      print('Performing Like');
      await like(tweet);
      return true;
    }

  }

  @override
  Future<LikeRequestStatus> unlike(TweetObject tweet) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').doc(UserPreferences.getUserUID()).collection('likes').where('content', isEqualTo: tweet.content).get();

    querySnapshot.docs.forEach((element) {
      element.reference.delete();
    });

    return LikeRequestStatus(status: 'Success', code: 0);
  }

  @override
  Future<List<TweetObject>> getLikedTweets() async {
    List<TweetObject> list = [];
    await FirebaseFirestore.instance.collection('users').doc(UserPreferences.getUserUID()).collection('likes').get().then(
          (value) {
        for (var data in value.docs) {
          String content = data.data()['content'];
          String date = data.data()['date'];
          String profilePicture = data.data()['image'];
          String uID = data.data()['uid'];
          String handle = '@' + data.data()['uid'].toString().substring(0, 8);
          String userName = data.data()['username'];
          list.add(TweetObject(userName, uID, handle, content, profilePicture, date));
        }
      },
    );

    return list;
  }

}