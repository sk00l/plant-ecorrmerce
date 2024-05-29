import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        emit(const LoginSuccess(loginSuccessMessage: 'SUCCESS'));
      } catch (e) {
        emit(const LoginFailed(loginFailedMessage: 'failed'));
      }
    });

    on<AutoLoginRequested>((event, emit) async {
      emit(LoggingIn());

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
