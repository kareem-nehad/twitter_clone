import 'package:twitter_clone/app/data/models/LikeRequestStatus.dart';
import 'package:twitter_clone/app/domain/entities/tweet.dart';
import 'package:twitter_clone/app/domain/repository/base_like_repository.dart';

import '../source/like_data_source.dart';

class LikeRepository extends BaseLikeRepository {
  final BaseLikeDataSource baseLikeDataSource;

  LikeRepository({required this.baseLikeDataSource});

  @override
  Future<LikeRequestStatus> like(TweetObject tweet) async {
    return await baseLikeDataSource.like(tweet);
  }

  @override
  Future<bool> isLiked(TweetObject tweet) async {
    return await baseLikeDataSource.isLiked(tweet);
  }

  @override
  Future<LikeRequestStatus> unlike(TweetObject tweet) async {
    return await baseLikeDataSource.unlike(tweet);
  }

  @override
  Future<List<TweetObject>> getLikedTweets() async {
    return await baseLikeDataSource.getLikedTweets();
  }


}
