import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plant_ecommerce/ui/screens/home_screen.dart';
import 'package:plant_ecommerce/ui/screens/login_screen.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
    ],
  );
}
