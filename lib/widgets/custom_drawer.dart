import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomDrawer extends StatelessWidget {
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
            onTap: () {
              Navigator.pushNamed(context, "/perfil");
            },
          ),
          ListTile(
            leading: Icon(Icons.lock, color: AppColors.primary),
            title: Text("🔑 Cuentas"),
            onTap: () {
              Navigator.pushNamed(context, "/cuentas");
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts, color: AppColors.primary),
            title: Text("☎️ Contactos"),
            onTap: () {
              Navigator.pushNamed(context, "/contactos");
            },
          ),
        ],
      ),
    );
  }
}
