import 'package:deliverly/data/services/api_services.dart';
import 'package:deliverly/models/repartidor_model.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

  Future<Repartidor?> login(String usuario, String password) async {
    final response = await apiService.post("login.php", {
      "usuario": usuario,
      "password": password,
    });

    if (response["success"] == true) {
      return Repartidor.fromJson(response);
    }

    return null;
  }
}
