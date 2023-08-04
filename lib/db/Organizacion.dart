// ignore: file_names
class Organizacion {
  String nombre;
  String telefono;
  String correo;
  String direccion;
  String usuario;
  String password;

  // Constructor
  Organizacion({
    required this.nombre,
    required this.telefono,
    required this.correo,
    required this.direccion,
    required this.usuario,
    required this.password,
  });

  // Método toJson para convertir el objeto a un mapa (Map) con formato JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'telefono': telefono,
      'correo': correo,
      'direccion': direccion,
      'usuario': usuario,
      'password': password,
    };
  }

  // Método fromJson para crear un objeto Usuario a partir de un mapa JSON
  factory Organizacion.fromJson(Map<String, dynamic> json) {
    return Organizacion(
      nombre: json['nombre'],
      telefono: json['telefono'],
      correo: json['correo'],
      direccion: json['direccion'],
      usuario: json['usuario'],
      password: json['password'],
    );
  }
}

