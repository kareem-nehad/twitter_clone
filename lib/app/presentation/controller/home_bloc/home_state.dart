import 'package:equatable/equatable.dart';

import '../../../domain/entities/tweet.dart';

enum HomeStatus { success, failure, loading }

class HomeState extends Equatable {
  final String userName;
  final List<TweetObject> tweets;
  final HomeStatus status;

  HomeState({
    this.userName = '',
    required this.tweets,
    this.status = HomeStatus.loading,
  });

  HomeState copyWith({
    String? userName,
    List<TweetObject>? tweets,
    HomeStatus? status
}) {
    return HomeState(
      userName: userName ?? this.userName,
      tweets: tweets ?? this.tweets,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [userName, tweets, status];
}
