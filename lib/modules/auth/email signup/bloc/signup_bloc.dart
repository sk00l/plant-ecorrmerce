import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_ecommerce/configs/locator/service_locator.dart';
import 'package:plant_ecommerce/modules/auth/email%20signup/email_signup_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(SignupProcess());
      try {
        await emailSignUpRepository.createUserWithEmailPassword(
            event.email, event.password, event.fname, event.lname);
        emit(SignupSuccess(successMessage: 'Sign up success'));
      } catch (e) {
        emit(SignupFailed(failureMessage: e.toString()));
      }
    });
  }

  EmailSignUpRepository emailSignUpRepository = getIt<EmailSignUpRepository>();
}
