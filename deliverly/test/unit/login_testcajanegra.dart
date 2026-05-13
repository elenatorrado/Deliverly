import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:deliverly/screens/login_screens.dart';

void main() {
  testWidgets('descripción', (tester) async {
    // 1. ARRANGE - carga la pantalla
    await tester.pumpWidget(const MaterialApp(home: LoginScreens()));

    // 2. ASSERT - comprueba lo que ve el usuario
    expect(find.text('Inicio de Sesión'), findsOneWidget);
  });
  testWidgets('se ve el campo de usuario', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreens()));

    expect(find.text('Introduce el usuario'), findsOneWidget);
  });

  testWidgets('se ve el botón Iniciar Sesion', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreens()));

    expect(find.text('Iniciar Sesion'), findsOneWidget);
  });
}
