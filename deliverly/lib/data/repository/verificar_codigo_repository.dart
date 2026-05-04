import 'package:deliverly/data/services/api_services.dart';

class VerificarCodigoRepository {
  final ApiService api;

  VerificarCodigoRepository({required this.api});

  Future<bool> verificarCodigo(int idPedido, String codigo) async {
    final response = await api.post("verificar_codigo.php", {
      "idPedido": idPedido,
      "codigo": codigo,
    });

    return response["success"] == true;
  }
}
