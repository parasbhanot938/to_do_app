import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/bloc/signup/signup_bloc.dart';
import 'package:to_do_app/data/auth_provider.dart';
import 'package:to_do_app/model/user_model.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var fullNameNode = FocusNode();
  var emailNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  AuthRepoProvider authRepoProvider;
  LoginBloc({required this.authRepoProvider}) : super(LoginInitial()) {
    on<OnChangeEvent>(onChangeEvent);
    on<SignUpClickedEvent>(signUpClickedEvent);
    on<SignInButtonPressedEvent>(signInButtonPressedEvent);

  }

  FutureOr<void> onChangeEvent(OnChangeEvent event, Emitter<LoginState> emit) {
    if (event.map.containsKey("password")) {
      passwordController.text = event.map["password"];

      debugPrint(" password ${passwordController.text}");
    } else {
      emailController.text = event.map["emailAddress"];
    }
  }


  FutureOr<void> signUpClickedEvent(SignUpClickedEvent event, Emitter<LoginState> emit) {
    debugPrint("pppp");
    emit(NavigatToSignupActionState());

  }

  Future<void> signInButtonPressedEvent(SignInButtonPressedEvent event, Emitter<LoginState> emit) async {

    if(formKey.currentState!.validate()){


      var data=await authRepoProvider.fetchRegisteredUserEmailPass();
      print("data ${data}");

      if(emailController.text==data["email"] && authRepoProvider.verifyPass(passwordController.text, data['password'])) {


        emit(NavigateToTodoScreenActionState(email: emailController.text));
        emit(ShowSnackBarActionState(messsage: "Logged In Successfully"));


      }
      else{
        emit(ShowSnackBarActionState(messsage: "User Not Found"));

      }






   UserModel? userModel=   await authRepoProvider.fetchUserData();

    }

  }
}
