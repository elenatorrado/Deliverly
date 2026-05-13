import 'package:flutter_test/flutter_test.dart';
import 'package:deliverly/models/codigos_model.dart';

void main() {
  test('Codigos correctos', () {
    final json = {"idPedido": 1, "codigoEntregaCliente": "4568742"};
    final codigo = CodigosModel.fromJson(json);
    expect(codigo.id, equals(1));
    expect(codigo.codigo, equals("4568742"));
  });
}
