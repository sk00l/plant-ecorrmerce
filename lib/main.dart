import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_ecommerce/configs/locator/service_locator.dart';
import 'package:plant_ecommerce/configs/router/app_router.dart';
import 'package:plant_ecommerce/firebase_options.dart';
import 'package:plant_ecommerce/modules/auth/email%20signup/bloc/signup_bloc.dart';
import 'package:plant_ecommerce/modules/auth/email%20signup/email_signup_repository.dart';

Future<void> main() async {
  runApp(
    SizedBox(
      child: Image.asset(
        'assets/images/spl.png',
        fit: BoxFit.cover,
      ),
    ),
  );
  await Future.delayed(const Duration(seconds: 2));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => EmailSignUpRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignupBloc(),
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData(
              fontFamily: 'TT Firs',
              scaffoldBackgroundColor:
                  const Color.fromARGB(255, 245, 245, 245)),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
