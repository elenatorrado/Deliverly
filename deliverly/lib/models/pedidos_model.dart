class PedidosModel {
  final int id;
  final String descripcion;
  final String direccion;
  final String estado;
  final String franjaHorario;
  final String nombreCliente;
  final String telefonoCliente;

  PedidosModel({
    required this.id,
    required this.descripcion,
    required this.direccion,
    required this.estado,
    required this.franjaHorario,
    required this.nombreCliente,
    required this.telefonoCliente,
  });

  factory PedidosModel.fromJson(Map<String, dynamic> json) {
    return PedidosModel(
      id: int.parse((json["idPedido"] ?? 0).toString()),
      descripcion: json["descripcionPedido"] ?? '',
      direccion: json["direccionPedido"] ?? '',
      estado: json["estadoPedido"] ?? '',
      franjaHorario: json["franjaHorario"] ?? '',
      nombreCliente: json["nombreCliente"] ?? '',
      telefonoCliente: json["telefonoCliente"] ?? '',
    );
  }

  String get franjaCerrada {
    if (franjaHorario.isEmpty) return "";

    // coger la hora (ej: "10:00 - 10:30" → 10)
    final hora = int.tryParse(franjaHorario.split(":")[0]) ?? 0;

    if (hora >= 9 && hora < 12) {
      return "09:00 - 12:00";
    } else if (hora >= 12 && hora < 14) {
      return "12:00 - 14:00";
    } else if (hora >= 17 && hora < 19) {
      return "17:00 - 19:00";
    } else if (hora >= 19 && hora < 21) {
      return "19:00 - 21:00";
    } else {
      return "Fuera de horario";
    }
  }
}
