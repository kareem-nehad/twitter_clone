import '../entities/tweet.dart';

abstract class BaseFeedRepository {
  Future<List<TweetObject>> getFeed();
}