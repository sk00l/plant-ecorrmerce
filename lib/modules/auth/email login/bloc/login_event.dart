part of 'login_bloc.dart';

sealed class LoginEvent {}

final class LoginAuthenticationRequested extends LoginEvent {
  final String email;
  final String password;

  LoginAuthenticationRequested({required this.email, required this.password});
}

final class AutoLoginRequested extends LoginEvent {}

final class LogoutRequested extends LoginEvent {}
