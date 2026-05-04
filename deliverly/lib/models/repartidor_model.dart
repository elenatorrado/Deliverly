class Repartidor {
  final int id;
  final String usuario;
  final String disponibilidad;

  Repartidor({
    required this.id,
    required this.usuario,
    required this.disponibilidad,
  });

  factory Repartidor.fromJson(Map<String, dynamic> json) {
    return Repartidor(
      id: int.parse((json["idRepartidor"] ?? 0).toString()),
      usuario: (json["usuarioRepartidor"] ?? '').toString(),
      disponibilidad: (json["disponibilidadRepartidor"] ?? '').toString(),
    );
  }
}
