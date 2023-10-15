part of 'like_bloc.dart';

@immutable
abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}
class Like extends LikeEvent {
  final TweetObject tweet;
  const Like({required this.tweet});
}

class Unlike extends LikeEvent {
  final TweetObject tweet;
  const Unlike({required this.tweet});
}

class isLiked extends LikeEvent {
  final TweetObject tweet;
  const isLiked({required this.tweet});
}

class getLikedEvent extends LikeEvent {
  const getLikedEvent();
}
