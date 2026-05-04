import 'package:deliverly/data/services/api_services.dart';
import 'package:deliverly/models/pedidos_model.dart';

class PedidosPendientesRepository {
  final ApiService apiSer;

  PedidosPendientesRepository({required this.apiSer});

  Future<List<PedidosModel>> getPedidosPendientes() async {
    final response = await apiSer.get("pedidos_pendientes.php");

    if (response["success"] == true) {
      return (response["data"] as List)
          .map((e) => PedidosModel.fromJson(e))
          .toList();
    }

    return [];
  }
}
