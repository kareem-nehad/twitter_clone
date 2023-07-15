import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:twitter_clone/app/domain/entities/tweet.dart';

import '../../domain/entities/full_user_data.dart';

abstract class BaseFullUserDataSource {
  Future<FullUserData> getFullUserData(String uid);
}

class FullUserDataSource extends BaseFullUserDataSource {
  @override
  Future<FullUserData> getFullUserData(String uid) async {
    ValueNotifier<List<TweetObject>> tweets = ValueNotifier([]);
    ValueNotifier<String> username = ValueNotifier('');
    ValueNotifier<String> uID = ValueNotifier('');
    ValueNotifier<String> userImage = ValueNotifier('');

    // To Get User's Tweets
    await FirebaseFirestore.instance.collection('users').doc(uid).collection('tweets').get().then((value) async {
      for (var data in value.docs) {
        if (data.data().isNotEmpty) {
          tweets.value.add(
            TweetObject(
              data.data()['username'],
              data.data()['uid'],
              '@' + data.data()['uid'].toString().substring(0, 8),
              data.data()['content'],
              data.data()['image'],
              data.data()['date'],
            ),
          );
        }
      }
    });

    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      Map<String, dynamic>? data = value.data();
      username.value = data!['username'];
      uID.value = '@' + data['uid'].toString().substring(0,8);
      userImage.value = data['image'];
    });

    return FullUserData(username: username.value, uid: uID.value, userImage: userImage.value, tweets: tweets.value);
  }
}
