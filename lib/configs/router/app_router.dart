import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plant_ecommerce/ui/screens/cart_screen.dart';
import 'package:plant_ecommerce/ui/screens/details_screen.dart';
import 'package:plant_ecommerce/ui/screens/home_screen.dart';
import 'package:plant_ecommerce/ui/screens/login_screen.dart';
import 'package:plant_ecommerce/ui/screens/onboarding_screen.dart';
import 'package:plant_ecommerce/ui/screens/plant_add_screen.dart';
import 'package:plant_ecommerce/ui/screens/signup_screen.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/onboard',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'detailsScreen',
            builder: (context, state) => const DetailsScreen(),
          ),
          GoRoute(
            path: 'cartPage',
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: 'plantAddPage',
            builder: (context, state) => const PlantAddScreen(),
          )
        ],
      ),
      GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: 'signup',
              builder: (context, state) => const SignUpScreen(),
            ),
          ]),
      GoRoute(
        path: '/onboard',
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
    ],
  );
}
