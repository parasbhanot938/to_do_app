part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}
abstract class SignupActionState extends SignupState {}
class ShowMessageActionState extends SignupActionState{
  String message;
  ShowMessageActionState({required this.message});
}

class NavigateToAddTodoActionState extends SignupActionState{

  String email;

  NavigateToAddTodoActionState({required this.email});

}
class NavigateToSignInActionState extends SignupActionState{}
class SignupInitial extends SignupState {}
