import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tweet.dart';
import '../../../domain/usecases/full_user_data_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetFullUserData fullUserDataUsecase;

  ProfileBloc(this.fullUserDataUsecase) : super(ProfileState(tweets: [])) {
    on<GetFullUserDataEvent>(_getFullUserData);
  }

  FutureOr<void> _getFullUserData(GetFullUserDataEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await fullUserDataUsecase.execute(event.uid);
    emit(state.copyWith(username: result.username, userImage: result.userImage, uid: result.uid, tweets: result.tweets, status: ProfileStatus.success));
  }
}
