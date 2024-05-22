import 'package:get_it/get_it.dart';
import 'package:plant_ecommerce/modules/auth/email%20signup/email_signup_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<EmailSignUpRepository>(
      () => EmailSignUpRepository());
}
