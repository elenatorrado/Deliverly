class LlamadasModel {
  //Definimos la variables que va tener las llamadas
  final int id;
  final String nombreCliente;
  final String telefonoCliente;
  final String direccion;
  final String franjaHorario;
  final String estado;

  //Como necesitamos obligatoriamente todos los datos se crea el constructor
  LlamadasModel({
    required this.id,
    required this.nombreCliente,
    required this.telefonoCliente,
    required this.direccion,
    required this.franjaHorario,
    required this.estado,
  });
  //Convierte datos que vienen en JSON en un objeto Dart
  factory LlamadasModel.fromJson(Map<String, dynamic> json) {
    return LlamadasModel(
      id: int.parse(json["idPedido"].toString()),
      nombreCliente: json["nombreCliente"] ?? '',
      telefonoCliente: json["telefonoCliente"] ?? '',
      direccion: json["direccionPedido"] ?? '',
      franjaHorario: json["franjaHorario"] ?? '',
      estado: json["estadoPedido"] ?? '',
    );
  }
}
