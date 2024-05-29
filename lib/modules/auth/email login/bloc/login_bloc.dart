import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plant_ecommerce/configs/locator/service_locator.dart';
import 'package:plant_ecommerce/modules/auth/email%20login/repository/email_login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginAuthenticationRequested>((event, emit) async {
      emit(LoggingIn());

      try {
        await emailLoginRepository.signInWithEmailPassword(
            event.email, event.password);
        if (event.email == null && event.password == null) {
          emit(const LoginFailed(loginFailedMessage: 'failed'));
        } else {
          emit(const LoginSuccess(loginSuccessMessage: 'login success'));
        }
      } catch (e) {
        emit(const LoginFailed(loginFailedMessage: 'failed'));
      }

      emit(const LoginSuccess(loginSuccessMessage: 'logged in successfully'));

      // emit(const LoginFailed(loginFailedMessage: 'failed to login'));
    });

    on<AutoLoginRequested>((event, emit) async {
      emit(LoggingIn());

      await Future.delayed(const Duration(seconds: 2));

      try {
        final userCredential = await emailLoginRepository.autoLogin();
        if (userCredential.user != null) {
          emit(LoginAuthenticationSuccess());
        } else {
          emit(LoginAuthenticationFailed());
        }
      } catch (e) {
        emit(LoginAuthenticationFailed());
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(LoggingOut());

      await emailLoginRepository.signOut();

      emit(
          const LogoutSuccess(logoutSuccessMessage: 'logged out successfully'));
    });
  }

  EmailLoginRepository emailLoginRepository = getIt.get<EmailLoginRepository>();
}
