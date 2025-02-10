import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/data/auth_provider.dart';
import 'package:to_do_app/model/user_model.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassController = TextEditingController();
  var fullNameNode = FocusNode();
  var emailNode = FocusNode();
  var passNode = FocusNode();
  var confirmPassNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  bool isPassObscure=true;
  bool isConfirmPassObscure=true;
  AuthRepoProvider authRepoProvider;

  SignupBloc({required this.authRepoProvider}) : super(SignupInitial()) {
    on<SignupButtonPressedEvent>(signupButtonPressedEvent);
    on<OnChangedEvent>(onChangedEvent);
    on<SignInClickedEvent>(signInClickedEvent);
    on<PassFieldEyeIconEvent>(passFieldEyeIconEvent);
    on<ConfirmFieldEyeIconEvent>(confirmFieldEyeIconEvent);
  }

  Future<void> signupButtonPressedEvent(
      SignupButtonPressedEvent event, Emitter<SignupState> emit) async {
    if (formKey.currentState!.validate()) {
      UserModel userModel = UserModel(
        fullName: fullNameController.text,
        email: emailController.text,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      UserModel? fetchedModel = await authRepoProvider.fetchUserData();
      debugPrint("check ${fetchedModel?.email == userModel.email}");
      if (fetchedModel?.email == userModel.email) {
        emit(ShowMessageActionState(message: 'User Already Exists'));
      } else {
        authRepoProvider.addUseData(
            userModel: userModel, password: event.password);
        emit(NavigateToAddTodoActionState(email: userModel.email));
        // await authRepoProvider.fetchUserData();
      }
    }
  }

  FutureOr<void> onChangedEvent(
      OnChangedEvent event, Emitter<SignupState> emit) {
    if (event.map.containsKey("fullName")) {
      fullNameController.text = event.map["fullName"];

      debugPrint(" full name ${fullNameController.text}");
    } else if (event.map.containsKey("emailAddress")) {
      emailController.text = event.map["emailAddress"];

      debugPrint(" emailAddress ${fullNameController.text}");
    } else if (event.map.containsKey("password")) {
      passwordController.text = event.map["password"];

      debugPrint(" password ${passwordController.text}");
    } else {
      confirmPassController.text = event.map["confirmPassword"];

      debugPrint(" confirmPassword ${confirmPassController.text}");
    }
  }

  FutureOr<void> signInClickedEvent(
      SignInClickedEvent event, Emitter<SignupState> emit) {
    emit(NavigateToSignInActionState());
  }

  FutureOr<void> passFieldEyeIconEvent(PassFieldEyeIconEvent event, Emitter<SignupState> emit) {
  isPassObscure=!isPassObscure;

  emit(ShowPassState(isPassObscure: isPassObscure));
  }

  FutureOr<void> confirmFieldEyeIconEvent(ConfirmFieldEyeIconEvent event, Emitter<SignupState> emit) {
    isConfirmPassObscure=!isConfirmPassObscure;

    emit(ShowConfirmPassState(isConfirmPassObscure: isConfirmPassObscure));

  }
}
