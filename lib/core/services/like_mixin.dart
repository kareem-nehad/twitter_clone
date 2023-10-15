import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/app/domain/entities/tweet.dart';

import '../utils/user_preferences.dart';

mixin LikeTweet {
  Future<void> like(TweetObject tweet) async {
    await FirebaseFirestore.instance.collection('users').doc(UserPreferences.getUserUID()).collection('likes').add({
      'content': tweet.content,
      'uid': tweet.handle,
      'username': tweet.userName,
      'image': tweet.profilePicture,
      'date': _getDate(),
    });
  }

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
      return true;
    } else {
      return false;
    }

  }

  Future<void> unlike(TweetObject tweet) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').doc(UserPreferences.getUserUID()).collection('likes').where('content', isEqualTo: tweet.content).get();

    querySnapshot.docs.forEach((element) {
      element.reference.delete();
    });
  }

  String _getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
}
