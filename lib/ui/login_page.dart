import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../services/mongodb_service.dart';
import '../utils/constants.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _storage = FlutterSecureStorage();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      // Encriptar contraseña ingresada
      final bytes = utf8.encode(_passController.text);
      final digest = sha256.convert(bytes);
      final encryptedPass = digest.toString();

      final users = await MongoDBService.getCollection('Usuarios')
          .find({'username': _userController.text}).toList();

      if (users.isNotEmpty && users[0]['password'] == encryptedPass) {
        await _storage.write(key: 'loggedUser', value: _userController.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales incorrectas')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Text(
              "¿Espera, nos conocemos?",
              style: AppTextStyles.bigTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Image.asset("assets/mascota.png", height: 200),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _userController,
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Ingresa tu usuario' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Ingresa tu contraseña' : null,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                      child: const Text('Ingresar',
                          style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      ),
                      child: Text('¿No tienes cuenta? ¡Creemos una!',
                          style: TextStyle(color: AppColors.primary)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}