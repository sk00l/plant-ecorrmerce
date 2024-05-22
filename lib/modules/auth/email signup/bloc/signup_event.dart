part of 'signup_bloc.dart';

sealed class SignupEvent {}

final class SignUpRequested extends SignupEvent {
  final String email;
  final String password;
  final String fname;
  final String lname;
  SignUpRequested({
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
  });
}
