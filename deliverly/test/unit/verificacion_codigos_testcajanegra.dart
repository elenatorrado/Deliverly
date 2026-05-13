import 'package:deliverly/screens/verificacion_entrega_screens.dart';
import 'package:flutter/material.dart'; // ← añade este
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Verificacion de codigo se ve correctamente', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: VerificacionEntregaScreens(idPedido: 1)),
    );
    expect(find.text('Entrega Pedido'), findsOneWidget);
    expect(find.text('Validar entrega'), findsOneWidget);
  });
}
