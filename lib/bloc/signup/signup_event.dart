part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class FetchInitialEvent extends SignupEvent {}

class SignInClickedEvent extends SignupEvent {}

class SignupButtonPressedEvent extends SignupEvent {
  String fullName;
  String email;
  String password;

  SignupButtonPressedEvent(
      {required this.fullName, required this.email, required this.password});
}

class OnChangedEvent extends SignupEvent {
  Map<String, dynamic> map;

  OnChangedEvent({required this.map});
}
