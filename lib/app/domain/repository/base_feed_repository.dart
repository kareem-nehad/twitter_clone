import '../entities/tweet.dart';

abstract class BaseFeedRepository {
  Future<List<Tweet>> getFeed();
}