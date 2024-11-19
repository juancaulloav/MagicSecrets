import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login_model.dart';

class AuthService {
  final String apiUrl = "http://<tu-api-url>/api/LoginApi/LoginMovil";

  Future<LoginResponse?> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        // Maneja los errores
        final error = jsonDecode(response.body);
        throw Exception(error['message']);
      }
    } catch (e) {
      print("Error al hacer login: $e");
      return null;
    }
  }
}
