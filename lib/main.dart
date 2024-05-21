import 'package:flutter/material.dart';
import 'package:plant_ecommerce/configs/router/app_router.dart';
import 'package:plant_ecommerce/ui/screens/home_screen.dart';
import 'package:plant_ecommerce/ui/screens/login_screen.dart';
import 'package:plant_ecommerce/ui/screens/onboarding_screen.dart';
import 'package:plant_ecommerce/ui/screens/signup_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          fontFamily: 'TT Firs',
          scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245)),
      routerConfig: AppRouter.router,
    );
  }
}
