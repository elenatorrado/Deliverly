import 'package:deliverly/screens/llamadas_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Se ve AppBar y boton refresh', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LlamadasScreens()));
    expect(find.text("Llamadas"), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });
}
