import 'package:flutter_test/flutter_test.dart';
import 'package:deliverly/models/pedidos_model.dart';

void main() {
  group('PedidosModel - fromJson', () {
    test('crea un pedido correctamente desde JSON', () {
      final json = {
        "idPedido": "1",
        "descripcionPedido": "Caja frágil",
        "direccionPedido": "Calle Mayor 5",
        "estadoPedido": "pendiente",
        "franjaHorario": "10:00 - 10:30",
        "nombreCliente": "Elena",
        "telefonoCliente": "600123456",
      };

      final pedido = PedidosModel.fromJson(json);

      expect(pedido.id, equals(1));
      expect(pedido.nombreCliente, equals("Elena"));
      expect(pedido.estado, equals("pendiente"));
    });

    test('usa valores por defecto si el JSON tiene campos nulos', () {
      final pedido = PedidosModel.fromJson({});

      expect(pedido.id, equals(0));
      expect(pedido.descripcion, equals(''));
      expect(pedido.estado, equals(''));
    });
  });

  group('PedidosModel - franjaCerrada', () {
    test('franja de mañana temprana: 09:00 - 12:00', () {
      final pedido = PedidosModel(
        id: 1,
        descripcion: '',
        direccion: '',
        estado: '',
        franjaHorario: '10:00 - 10:30',
        nombreCliente: '',
        telefonoCliente: '',
      );
      expect(pedido.franjaCerrada, equals('09:00 - 12:00'));
    });

    test('franja de mediodía: 12:00 - 14:00', () {
      final pedido = PedidosModel(
        id: 1,
        descripcion: '',
        direccion: '',
        estado: '',
        franjaHorario: '13:00 - 13:30',
        nombreCliente: '',
        telefonoCliente: '',
      );
      expect(pedido.franjaCerrada, equals('12:00 - 14:00'));
    });

    test('franja de tarde: 17:00 - 19:00', () {
      final pedido = PedidosModel(
        id: 1,
        descripcion: '',
        direccion: '',
        estado: '',
        franjaHorario: '17:30 - 18:00',
        nombreCliente: '',
        telefonoCliente: '',
      );
      expect(pedido.franjaCerrada, equals('17:00 - 19:00'));
    });

    test('franja de noche: 19:00 - 21:00', () {
      final pedido = PedidosModel(
        id: 1,
        descripcion: '',
        direccion: '',
        estado: '',
        franjaHorario: '20:00 - 20:30',
        nombreCliente: '',
        telefonoCliente: '',
      );
      expect(pedido.franjaCerrada, equals('19:00 - 21:00'));
    });

    test('fuera de horario', () {
      final pedido = PedidosModel(
        id: 1,
        descripcion: '',
        direccion: '',
        estado: '',
        franjaHorario: '08:00 - 08:30',
        nombreCliente: '',
        telefonoCliente: '',
      );
      expect(pedido.franjaCerrada, equals('Fuera de horario'));
    });

    test('franja vacía devuelve cadena vacía', () {
      final pedido = PedidosModel(
        id: 1,
        descripcion: '',
        direccion: '',
        estado: '',
        franjaHorario: '',
        nombreCliente: '',
        telefonoCliente: '',
      );
      expect(pedido.franjaCerrada, equals(''));
    });
  });
}
