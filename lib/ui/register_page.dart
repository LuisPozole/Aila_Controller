import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user_model.dart';
import '../services/mongodb_service.dart';
import '../utils/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      // Verificar usuario único
      final existingUser = await MongoDBService.getCollection('Usuarios')
          .findOne({'username': _userController.text});

      if (existingUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡El nombre de usuario ya existe!')),
        );
        return;
      }

      // Encriptar contraseña
      final bytes = utf8.encode(_passController.text);
      final digest = sha256.convert(bytes);
      final encryptedPassword = digest.toString();

      final newUser = User(
        id: DateTime.now().toString(),
        name: _nameController.text,
        username: _userController.text,
        email: _emailController.text,
        password: encryptedPassword,
      );

      await MongoDBService.getCollection('Usuarios').insert(newUser.toMap());
      
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Registro exitoso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Crear cuenta'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre completo'),
                validator: (value) =>
                    value!.isEmpty ? 'Este campo es obligatorio' : null,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Correo electrónico'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingresa un correo válido' : null,
              ),
              TextFormField(
                controller: _userController,
                decoration: const InputDecoration(labelText: 'Nombre de usuario'),
                validator: (value) =>
                    value!.isEmpty ? 'Elige un nombre de usuario' : null,
              ),
              TextFormField(
                controller: _passController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                validator: (value) =>
                    value!.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text('Registrarse',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}