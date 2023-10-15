import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:twitter_clone/app/domain/entities/tweet.dart';
import 'package:twitter_clone/app/domain/usecases/like_usecase.dart';

part 'like_event.dart';

part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikeUsecase likeUsecase;

  LikeBloc(this.likeUsecase) : super(LikeState(likedTweets: [])) {
    on<Like>(_like);
    on<Unlike>(_unlike);
    on<isLiked>(_isLiked);
    on<getLikedEvent>(_getLiked);
  }

  FutureOr<void> _like(Like event, Emitter<LikeState> emit) async {
    emit(state.copyWith(status: LikeStatus.awaiting));
    await likeUsecase.executeLike(state.tweet);
    emit(state.copyWith(status: LikeStatus.success));
  }

  FutureOr<void> _unlike(Unlike event, Emitter<LikeState> emit) async {
    await likeUsecase.executeUnlike(state.tweet);
    emit(state.copyWith(status: LikeStatus.success));
  }

  FutureOr<void> _isLiked(isLiked event, Emitter<LikeState> emit) async {
    emit(state.copyWith(status: LikeStatus.awaiting));
    bool response = await likeUsecase.executeIsLiked(event.tweet);
    if (response == true) {
      emit(state.copyWith(status: LikeStatus.success));
    } else {
      emit(state.copyWith(status: LikeStatus.failure));
    }
  }

  Future<void> _getLiked(getLikedEvent event, Emitter<LikeState> emit) async {
    List<TweetObject> list = await likeUsecase.getLikedTweets();
    emit(state.copyWith(status: LikeStatus.success, list: list));
  }
}
