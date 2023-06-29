part of 'tweet_bloc.dart';

enum TweetStatus {
  success,
  failure,
  loading,
  awaiting,
}

class TweetState extends Equatable {
  final Tweet? tweet;
  final TweetStatus status;

  TweetState({
    this.tweet = null,
    this.status = TweetStatus.awaiting,
  });

  TweetState copyWith({Tweet? tweet, TweetStatus? status}) {
    return TweetState(
      tweet: tweet ?? this.tweet,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [tweet, status];
}
