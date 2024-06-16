import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:plant_ecommerce/configs/api/api_endpoints.dart';
import 'package:plant_ecommerce/modules/auth/authentication_repository.dart';
import 'package:plant_ecommerce/modules/auth/email%20login/repository/email_login_repository.dart';
import 'package:plant_ecommerce/modules/auth/email%20signup/repository/email_signup_repository.dart';
import 'package:plant_ecommerce/modules/cart/repository/cart_repository.dart';
import 'package:plant_ecommerce/modules/plant_add/repository/plant_add_repository.dart';
import 'package:plant_ecommerce/services/api_services.dart';

final getIt = GetIt.instance;
// String apiKey = 'HDEV-d94ef62c-33de-47f8-a4f2-c98482ff116b';

void setup() {
  getIt.registerLazySingleton<EmailSignUpRepository>(
      () => EmailSignUpRepository());

  getIt.registerSingleton<PlantAddRepositorty>(PlantAddRepositorty());

  getIt.registerSingleton<EmailLoginRepository>(EmailLoginRepository());

  getIt.registerSingleton<CartRepository>(CartRepository());

  getIt.registerSingleton<Dio>(Dio(
    BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 6000),
        receiveTimeout: const Duration(seconds: 6000),
        headers: {
          'Content-Type': "application/json",
          'X-Api-Key': "19f5064aeabb4603a859da738df6bd6a",
        }),
  ));

  getIt.registerSingleton<ApiServices>(ApiServices());

  // repository initializaiions//

  GetIt.I.registerSingleton<AuthenticationRepository>(EmailLoginRepository());
}
