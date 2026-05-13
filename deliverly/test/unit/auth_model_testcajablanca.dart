import 'package:flutter_test/flutter_test.dart';
import 'package:deliverly/models/repartidor_model.dart';

void main() {
  test('crea un repartidor correctamente desde JSON', () {
    final json = {
      "idRepartidor": "5",
      "usuarioRepartidor": "elena",
      "disponibilidadRepartidor": "disponible",
    };
    final repartidor = Repartidor.fromJson(json);
    expect(repartidor.usuario, equals("elena"));
  });

  test('crea un repartidor correctamente', () {
    final repartidor = Repartidor(
      id: 5,
      usuario: "elena",
      disponibilidad: "disponible",
    );
    expect(repartidor.id, equals(5)); // ← qué campo y qué valor esperas
  });
}
