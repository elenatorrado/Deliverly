class CodigosModel {
  final String codigo;
  final int id;

  CodigosModel({required this.codigo, required this.id});

  factory CodigosModel.fromJson(Map<String, dynamic> json) {
    return CodigosModel(
      codigo: json["codigoEntregaCliente"] ?? '',
      id: int.parse(json["idPedido"].toString()),
    );
  }
}
