import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://10.0.2.2/deliverly/";

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse(baseUrl + endpoint));

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }
}
