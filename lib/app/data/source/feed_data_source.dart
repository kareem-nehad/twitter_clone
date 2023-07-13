import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:twitter_clone/core/utils/user_preferences.dart';

import '../../domain/entities/tweet.dart';

abstract class BaseFeedDataSource {
  Future<List<TweetObject>> getFeed();
}

class FeedDataSource extends BaseFeedDataSource {
  @override
  Future<List<TweetObject>> getFeed() async {
    ValueNotifier<List<TweetObject>> tweets = ValueNotifier([]);

    await FirebaseFirestore.instance
        .collectionGroup('tweets')
        .get()
        .then((value) async {
      for (var data in value.docs) {
        if (data.data().isNotEmpty) {
          tweets.value.add(TweetObject(
            data.data()['username'],
            '@' + data.data()['uid'].toString().substring(0, 8),
            data.data()['content'],
            UserPreferences.getUserImage()!
          ));
        }
      }
    });

    return tweets.value;
  }
}
