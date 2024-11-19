class LoginRequest {
  final String rut;
  final String clave;

  LoginRequest({required this.rut, required this.clave});

  Map<String, dynamic> toJson() {
    return {
      "Rut": rut,
      "Clave": clave,
    };
  }
}

class LoginResponse {
  final String message;
  final Map<String, dynamic>? usuario;

  LoginResponse({required this.message, this.usuario});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      usuario: json['usuario'],
    );
  }
}
