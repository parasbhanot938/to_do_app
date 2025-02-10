part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}
abstract class SignupActionState extends SignupState {}
class ShowMessageActionState extends SignupActionState{
  String message;
  ShowMessageActionState({required this.message});
}
class ShowPassState extends SignupState{

  bool isPassObscure;
  ShowPassState({required this.isPassObscure});
}
class ShowConfirmPassState extends SignupState{
  bool isConfirmPassObscure;
  ShowConfirmPassState({required this.isConfirmPassObscure});
}

class NavigateToAddTodoActionState extends SignupActionState{

  String email;

  NavigateToAddTodoActionState({required this.email});

}
class NavigateToSignInActionState extends SignupActionState{}
class SignupInitial extends SignupState {}
