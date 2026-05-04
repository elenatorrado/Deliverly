import 'package:deliverly/core/app_colors.dart';
import 'package:deliverly/core/text_style.dart';
import 'package:deliverly/screens/login_screens.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // animación
    Future.delayed(const Duration(milliseconds: 20), () {
      setState(() {
        opacity = 1.0;
      });
    });

    // navegación al login
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreens()),
      );
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Center(
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(seconds: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/iconoapp.png", width: 150),
                const SizedBox(height: 20),
                Text("Deliverly", style: TextStyles.title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
