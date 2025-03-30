class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String password;
  final String tipoUsuario;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    this.tipoUsuario = "Normal",
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'tipoUsuario': tipoUsuario,
      'apikey': null,
      'contacto': null,
    };
  }
}