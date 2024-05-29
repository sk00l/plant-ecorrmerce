import 'package:get_it/get_it.dart';
import 'package:plant_ecommerce/modules/auth/email%20login/repository/email_login_repository.dart';
import 'package:plant_ecommerce/modules/auth/email%20signup/repository/email_signup_repository.dart';
import 'package:plant_ecommerce/modules/cart/repository/cart_repository.dart';
import 'package:plant_ecommerce/modules/plant_add/repository/plant_add_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<EmailSignUpRepository>(
      () => EmailSignUpRepository());

  getIt.registerSingleton<PlantAddRepositorty>(PlantAddRepositorty());

  getIt.registerSingleton<EmailLoginRepository>(EmailLoginRepository());

  getIt.registerSingleton<CartRepository>(CartRepository());
}
