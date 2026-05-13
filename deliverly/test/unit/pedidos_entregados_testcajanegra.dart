import 'package:deliverly/screens/pedidos_entregados.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Se ve appbar y el boton refresh', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PedidosEntregados()));
    expect(find.text("Pedidos Entregados"), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });
}
