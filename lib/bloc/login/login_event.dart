part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class SignUpClickedEvent extends LoginEvent{}

class OnChangeEvent extends LoginEvent {
  Map<String, dynamic> map;

  OnChangeEvent({required this.map});
}

class SignInButtonPressedEvent extends LoginEvent {
  String email;
  String password;

  SignInButtonPressedEvent({required this.email, required this.password});
}
