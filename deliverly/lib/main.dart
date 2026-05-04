import 'package:deliverly/screens/login_screens.dart';
import 'package:deliverly/screens/main_screen.dart';

import 'package:deliverly/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // pantalla inicial
      initialRoute: "/",

      routes: {
        "/": (context) => const SplashScreen(),
        "/login": (context) => const LoginScreens(),
        "/home": (context) => const MainScreen(),
      },
    );
  }
}
