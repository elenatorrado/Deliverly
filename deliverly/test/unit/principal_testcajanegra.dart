import 'package:deliverly/screens/principal_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Se ve appbar correctamente', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PrincipalScreens()));

    expect(find.text('Pedidos Pendientes'), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });
}
