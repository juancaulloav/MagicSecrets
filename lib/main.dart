import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _rutController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final loginRequest = LoginRequest(
        rut: _rutController.text,
        clave: _passwordController.text,
      );

      try {
        final response = await _authService.login(loginRequest);

        if (response != null && response.usuario != null) {
          // Login exitoso, mostrar mensaje con el nombre del usuario
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Bienvenido, ${response.usuario!['Nombre']}'),
            ),
          );
        } else {
          // Mensaje de error del servidor
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response?.message ?? 'Error desconocido')),
          );
        }
      } catch (e) {
        // Error en la conexión o en el proceso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al conectarse con el servidor')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _rutController,
                decoration: InputDecoration(
                  labelText: 'RUT',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu RUT';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu contraseña';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
