import 'package:twitter_clone/app/domain/entities/tweet.dart';

import '../../data/models/tweet_status.dart';

abstract class BaseTweetRepository {
  Future<TweetRequestStatus> tweet(TweetObject tweet);
}