// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {
  final String loginSuccessMessage;
  const LoginSuccess({
    required this.loginSuccessMessage,
  });

  @override
  List<Object> get props => [loginSuccessMessage];
}

final class LogoutSuccess extends LoginState {
  final String logoutSuccessMessage;
  const LogoutSuccess({
    required this.logoutSuccessMessage,
  });

  @override
  List<Object> get props => [logoutSuccessMessage];
}

final class LoginFailed extends LoginState {
  final String loginFailedMessage;
  const LoginFailed({
    required this.loginFailedMessage,
  });

  @override
  List<Object> get props => [loginFailedMessage];
}

final class LoggingIn extends LoginState {}

final class LoggingOut extends LoginState {}

final class LoginAuthenticationSuccess extends LoginState {}

final class LoginAuthenticationFailed extends LoginState {}
