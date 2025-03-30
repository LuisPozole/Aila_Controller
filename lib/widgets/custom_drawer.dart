import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/constants.dart';

class CustomDrawer extends StatelessWidget {
  final _storage = FlutterSecureStorage(); // Instancia de almacenamiento seguro

  Future<void> _logout(BuildContext context) async {
    await _storage.delete(key: 'loggedUser'); // Eliminar la sesión
    Navigator.pushReplacementNamed(context, '/login'); // Redirigir al login
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: Center(
              child: Text(
                "Menú",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: AppColors.primary),
            title: Text("📌 Perfil"),
            onTap: () => Navigator.pushNamed(context, "/perfil"),
          ),
          ListTile(
            leading: Icon(Icons.lock, color: AppColors.primary),
            title: Text("🔑 Cuentas"),
            onTap: () => Navigator.pushNamed(context, "/cuentas"),
          ),
          ListTile(
            leading: Icon(Icons.contacts, color: AppColors.primary),
            title: Text("☎️ Contactos"),
            onTap: () => Navigator.pushNamed(context, "/contactos"),
          ),
          Divider(color: AppColors.primary), // Línea separadora
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red), // Icono destacado
            title: Text("Cerrar sesión", style: TextStyle(color: Colors.red)),
            onTap: () => _logout(context), // Ejecutar cierre de sesión
          ),
        ],
      ),
    );
  }
}