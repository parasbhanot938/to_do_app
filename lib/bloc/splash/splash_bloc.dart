import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/data/auth_provider.dart';
import 'package:to_do_app/model/user_model.dart';
import 'package:to_do_app/ui/add_todo_screen.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  AuthRepoProvider authRepoProvider;

  SplashBloc({required this.authRepoProvider}) : super(SplashInitial()) {
    on<FetchInitialEvent>(fetchInitialEvent);
  }

  Future<void> fetchInitialEvent(
      FetchInitialEvent event, Emitter<SplashState> emit) async {
    UserModel? userModel = await authRepoProvider.fetchUserData();

    await Future.delayed(
      const Duration(seconds: 3),
      () {
        debugPrint("user model ${userModel?.email}");
        if (userModel != null && userModel!.email.isNotEmpty) {
          emit(NavigateToAddTodoScreenActionState(userModel: userModel));
        } else {
          emit(NavigateToSignupActionState());
        }
      },
    );
  }
}
