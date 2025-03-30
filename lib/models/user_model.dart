class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String password;
  final String tipoUsuario;
  final List<Map<String, dynamic>> ubicacion; // Arreglo de direcciones

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    this.tipoUsuario = "Normal",
    this.ubicacion = const [], // Inicializado como arreglo vacío
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'tipoUsuario': tipoUsuario,
      'ubicacion': ubicacion, // Incluye la dirección registrada
      'contacto': [],
      'apikey': null,
    };
  }
}