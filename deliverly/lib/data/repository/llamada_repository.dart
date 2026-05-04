import 'package:deliverly/data/services/api_services.dart';
import 'package:deliverly/models/llamadas_model.dart';

class LlamadaRepository {
  //Se le indica que la api service sabe hablar con el PHP
  ApiService apiSer = ApiService();
  //Se utiliza àra utilizarlo a fuera
  LlamadaRepository({required this.apiSer});

  //Future porque le indicamos que es un proceso que tarda
  Future<List<LlamadasModel>> getLlamadas() async {
    //Aqui guardamos la respuesta del archivo(si es success o no)
    final response = await apiSer.get("llamadas.php");

    //Indicamos que si la respuesta es success
    if (response["success"] == true) {
      //Me traiga los datos JSON como lista
      return (response["data"] as List)
          //Convertimos cada datos JSON en dart
          .map((e) => LlamadasModel.fromJson(e))
          //Lo hacemos Lista
          .toList();
    }
    //Si Falla nos devuelve una lista vacia
    return [];
  }
}
