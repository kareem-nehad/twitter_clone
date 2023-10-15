import 'package:twitter_clone/app/domain/entities/tweet.dart';

import '../../data/models/LikeRequestStatus.dart';
import '../repository/base_like_repository.dart';

class LikeUsecase {
  final BaseLikeRepository baseLikeRepository;

  LikeUsecase(this.baseLikeRepository);

  Future<LikeRequestStatus> executeLike(TweetObject? tweet) async {
    return await baseLikeRepository.like(tweet!);
  }

  Future<LikeRequestStatus> executeUnlike(TweetObject? tweet) async {
    return await baseLikeRepository.unlike(tweet!);
  }

  Future<bool> executeIsLiked (TweetObject tweet) async {
    return await baseLikeRepository.isLiked(tweet);
  }

  Future<List<TweetObject>> getLikedTweets() async {
    return await baseLikeRepository.getLikedTweets();
  }

}
