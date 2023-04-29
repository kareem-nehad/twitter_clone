import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:twitter_clone/app/data/models/login_request_status_model.dart';

import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  LoginBloc(this.loginUsecase) : super(LoginState()) {
    on<Login>(_login);
  }

  Future<void> _login(Login event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.awaiting));
    final LoginRequestStatus response;
    response = await loginUsecase.execute(event.email, event.password);
    switch (response.code) {
      case 0:
        emit(state.copyWith(status: LoginStatus.success));
        break;
      case 1:
        emit(state.copyWith(status: LoginStatus.failure, message: response.status));
        break;
    }
  }
}

