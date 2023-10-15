import 'package:twitter_clone/app/domain/entities/tweet.dart';

import '../../data/models/LikeRequestStatus.dart';

abstract class BaseLikeRepository {
  Future<LikeRequestStatus> like(TweetObject tweet);
  Future<LikeRequestStatus> unlike(TweetObject tweet);
  Future<bool> isLiked(TweetObject tweet);
  Future<List<TweetObject>> getLikedTweets();
}