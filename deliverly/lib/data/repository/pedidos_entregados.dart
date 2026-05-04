import 'package:deliverly/data/services/api_services.dart';
import 'package:deliverly/models/pedidos_model.dart';

class PedidosEntregadosRepository {
  final ApiService apiSer;

  PedidosEntregadosRepository({required this.apiSer});

  Future<List<PedidosModel>> getPedidosEntregados() async {
    final response = await apiSer.get("pedidos_entregados.php");

    if (response["success"] == true) {
      return (response["data"] as List)
          .map((e) => PedidosModel.fromJson(e))
          .toList();
    }

    return [];
  }
}
