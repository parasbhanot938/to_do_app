part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}
abstract class SplashActionState extends SplashState{}
class NavigateToSignupActionState extends SplashActionState{

}


class NavigateToAddTodoScreenActionState extends SplashActionState{
  UserModel userModel;
  NavigateToAddTodoScreenActionState({required this.userModel});

}
class SplashInitial extends SplashState {}
class SplashLoadedState extends SplashState{}