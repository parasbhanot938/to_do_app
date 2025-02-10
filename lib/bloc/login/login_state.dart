part of 'login_bloc.dart';

@immutable
abstract class LoginState {}
abstract class LoginActionState extends LoginState {}
class ShowSnackBarActionState extends LoginActionState{
  String messsage;
  ShowSnackBarActionState({required this.messsage});
}

class ShowEyeClosedState extends LoginState{
  bool isObscure;
  ShowEyeClosedState({required this.isObscure});

}

class LoginInitial extends LoginState {}
class NavigatToSignupActionState extends LoginActionState{

}
class NavigateToTodoScreenActionState extends LoginActionState{

  String email;
  NavigateToTodoScreenActionState({required this.email});
}
