import 'package:flutter_test/flutter_test.dart';
import 'package:deliverly/models/llamadas_model.dart';

void main() {
  test('Telefono se carga correctamete', () {
    final json = {
      "idPedido": "1",
      "nombreCliente": "Elena",
      "telefonoCliente": "666777999",
      "direccionPedido": "Calle Mayor 5",
      "franjaHorario": "10:00 - 10:30",
      "estadoPedido": "pendiente",
    };
    final telefono = LlamadasModel.fromJson(json);
    expect(telefono.telefonoCliente, equals("666777999"));
  });
}
