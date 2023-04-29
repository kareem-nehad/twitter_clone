import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:twitter_clone/app/data/models/auth_request_status_model.dart';


import '../../../domain/usecases/create_account_usecase.dart';

part 'create_account_event.dart';
part 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  final CreateAccountUsecase createAccountUsecase;
  CreateAccountBloc(this.createAccountUsecase) : super(CreateAccountState()) {
    on<CreateAccount>(_createAccount);
  }
  
  Future<void> _createAccount(CreateAccount event, Emitter<CreateAccountState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final AuthRequestStatus response;
    response = await createAccountUsecase.execute(event.email, event.password);
    switch (response.code) {
      case 0:
        emit(state.copyWith(status: AuthStatus.success));
        break;
      case 1:
        emit(state.copyWith(status: AuthStatus.failure, message: response.status));
        break;
    }
  }
}
