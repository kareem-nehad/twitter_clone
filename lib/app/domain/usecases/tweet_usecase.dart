import 'package:twitter_clone/app/domain/repository/base_tweet_repository.dart';

import '../../data/models/tweet_status.dart';
import '../entities/tweet.dart';

class TweetUsecase {
  final BaseTweetRepository baseTweetRepository;

  TweetUsecase(this.baseTweetRepository);

  Future<TweetRequestStatus> execute(TweetObject tweet) async {
    return await baseTweetRepository.tweet(tweet);
  }
}