part of 'tweet_bloc.dart';

@immutable
abstract class TweetEvent extends Equatable {
  const TweetEvent();

  @override
  List<Object> get props => [];
}

class Tweet extends TweetEvent {
  final TweetObject tweet;
  const Tweet({required this.tweet});
}
