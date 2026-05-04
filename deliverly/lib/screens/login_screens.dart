import 'package:deliverly/core/app_colors.dart';
import 'package:deliverly/core/button_style.dart';
import 'package:deliverly/core/text_style.dart';
import 'package:deliverly/data/services/api_services.dart';
import 'package:deliverly/data/repository/auth_repository.dart';

import 'package:flutter/material.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  // 👇 SOLO AÑADIDO (no cambia tu UI)
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthRepository authRepository = AuthRepository(ApiService());

  bool isLoading = false;

  void login() async {
    setState(() => isLoading = true);

    final usuario = usuarioController.text.trim();
    final password = passwordController.text.trim();

    final success = await authRepository.login(usuario, password);

    setState(() => isLoading = false);

    if (success != null) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario o contraseña incorrectos")),
      );
    }
  }

  @override
  void dispose() {
    usuarioController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            Center(
              child: Column(
                children: [
                  Image.asset("assets/images/iconoapp.png", width: 200),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Center(child: Text("Inicio de Sesión", style: TextStyles.title)),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Usuario", style: TextStyles.label),
                  const SizedBox(height: 20),

                  TextField(
                    controller: usuarioController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF7F4F4),
                      hintText: "Introduce el usuario",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/icons/iconouser.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contraseña: ", style: TextStyles.label),
                  const SizedBox(height: 20),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Introduce contraseña",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/icons/candado.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 32,
                top: 60,
              ),

              child: ElevatedButton(
                onPressed: isLoading ? null : login,
                style: ButtonStyles.boton,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text("Iniciar Sesion", style: TextStyles.bodytextbtn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
