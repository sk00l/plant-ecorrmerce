import 'package:flutter/material.dart';
import 'package:plant_ecommerce/ui/components/plant_list_view.dart';
import 'package:plant_ecommerce/ui/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'TT Firs',
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      home: const HomeScreen(),
    );
  }
}
