import 'package:twitter_clone/app/domain/repository/base_feed_repository.dart';

import '../entities/tweet.dart';

class GetFeed {
  final BaseFeedRepository baseFeedRepository;

  GetFeed({required this.baseFeedRepository});

  Future<List<Tweet>> execute() async {
    return await baseFeedRepository.getFeed();
}
}