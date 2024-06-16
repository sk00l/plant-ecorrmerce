import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_ecommerce/configs/di/service_locator.dart';
import 'package:plant_ecommerce/modules/auth/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginAuthenticationRequested>((event, emit) async {
      emit(LoggingIn());

      try {
        await authenticationRepository.signInWithEmailPassword(
            event.email, event.password);
        emit(const LoginSuccess(loginSuccessMessage: 'SUCCESS'));
      } catch (e) {
        emit(const LoginFailed(loginFailedMessage: 'failed'));
      }
    });

    on<AutoLoginRequested>((event, emit) async {
      emit(LoggingIn());

      try {
        final userCredential = await authenticationRepository.autoLogin();
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

      await authenticationRepository.signOut();

      emit(
          const LogoutSuccess(logoutSuccessMessage: 'logged out successfully'));
    });
  }

  AuthenticationRepository authenticationRepository =
      getIt.get<AuthenticationRepository>();
}
