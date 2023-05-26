import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../domain/usecases/get_user_date_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserData getUserDataUseCase;

  HomeBloc(this.getUserDataUseCase) : super(HomeState()) {
   on<GetUserDataEvent>(_getUserData);
  }

  FutureOr<void> _getUserData(GetUserDataEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await getUserDataUseCase.execute();
    print(result);
    emit(state.copyWith(userName: result.username, status: HomeStatus.success));
  }
}
