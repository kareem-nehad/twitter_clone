import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:twitter_clone/app/data/models/tweet_status.dart';

import '../../../domain/entities/tweet.dart';
import '../../../domain/usecases/tweet_usecase.dart';
part 'tweet_event.dart';
part 'tweet_state.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  final TweetUsecase tweetUsecase;
  TweetBloc(this.tweetUsecase) : super(TweetState()) {
    on<Tweet>(_tweet);
  }

  FutureOr<void> _tweet(Tweet event, Emitter<TweetState> emit) async {
    emit(state.copyWith(status: TweetStatus.loading));
    final TweetRequestStatus response;
    response = await tweetUsecase.execute(event.tweet);
    switch (response.code) {
      case 0:
        emit(state.copyWith(status: TweetStatus.success));
    }
  }
}
