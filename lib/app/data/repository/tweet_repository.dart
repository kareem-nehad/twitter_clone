import 'package:twitter_clone/app/data/models/tweet_status.dart';
import 'package:twitter_clone/app/data/source/tweet_data_source.dart';
import 'package:twitter_clone/app/domain/entities/tweet.dart';
import 'package:twitter_clone/app/domain/repository/base_tweet_repository.dart';

class TweetRepository extends BaseTweetRepository {
  final BaseTweetDataSource baseTweetDataSource;

  TweetRepository({required this.baseTweetDataSource});

  @override
  Future<TweetRequestStatus> tweet(TweetObject tweet) async {
    return await baseTweetDataSource.tweet(tweet);
  }


}