import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../domain/usecases/feed_usecase.dart';
import '../../../domain/usecases/get_user_date_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserData getUserDataUseCase;
  final GetFeed getFeedUseCase;

  HomeBloc(this.getUserDataUseCase, this.getFeedUseCase) : super(HomeState(tweets: [])) {
   on<GetUserDataEvent>(_getUserData);
   on<GetFeedEvent>(_getHomeFeed);
  }

  FutureOr<void> _getUserData(GetUserDataEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await getUserDataUseCase.execute();
    emit(state.copyWith(userName: result.username, status: HomeStatus.success));
  }

  FutureOr<void> _getHomeFeed(GetFeedEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await getFeedUseCase.execute();
    emit(state.copyWith(tweets: result, status: HomeStatus.success));
  }
}
