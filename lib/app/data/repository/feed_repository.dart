import 'package:twitter_clone/app/domain/entities/tweet.dart';
import 'package:twitter_clone/app/domain/repository/base_feed_repository.dart';

import '../source/feed_data_source.dart';

class FeedRepository extends BaseFeedRepository{
  final BaseFeedDataSource baseFeedDataSource;


  FeedRepository({required this.baseFeedDataSource});

  @override
  Future<List<TweetObject>> getFeed() async{
    return await baseFeedDataSource.getFeed();
  }

}