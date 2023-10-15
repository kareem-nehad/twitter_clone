part of 'like_bloc.dart';

enum LikeStatus { success, loading, awaiting, failure}

class LikeState extends Equatable {
  final TweetObject? tweet;
  final bool liked;
  final LikeStatus status;
  final List<TweetObject> likedTweets;

  LikeState({
    this.tweet = null,
    this.liked = false,
    this.status = LikeStatus.awaiting,
    required this.likedTweets,
  });

  LikeState copyWith({TweetObject? tweet, bool? liked, LikeStatus? status,List<TweetObject>? list}) {
    return LikeState(
      tweet: this.tweet,
      liked: liked ?? this.liked,
      status: status ?? this.status,
      likedTweets: list ?? this.likedTweets,
    );
  }

  @override
  List<Object> get props => [liked, status, likedTweets];
}
