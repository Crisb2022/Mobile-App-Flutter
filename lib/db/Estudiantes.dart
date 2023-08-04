// ignore_for_file: file_names

class Estudiantes {
  String nombres;
  String apellidos;
  String cedula;
  String correo;
  String usuario;
  String password;
  String image;
  String nacimiento;

  Estudiantes({
    required this.nombres,
    required this.apellidos,
    required this.cedula,
    required this.correo,
    required this.usuario,
    required this.password,
    required this.image,
    required this.nacimiento,
  });

  factory Estudiantes.fromJson(Map<String, dynamic> json) {
    return Estudiantes(
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      cedula: json['cedula'],
      correo: json['correo'],
      usuario: json['usuario'],
      password: json['password'],
      image: json['image'],
      nacimiento: json['nacimiento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombres': nombres,
      'apellidos': apellidos,
      'cedula': cedula,
      'correo': correo,
      'usuario': usuario,
      'password': password,
      'image': image,
      'nacimiento': nacimiento,
    };
  }
}
