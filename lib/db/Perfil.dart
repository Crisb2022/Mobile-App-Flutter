class Perfil {
  String cedula;
  String vision;
  String carrera;
  String objetivo;
  String hojaVida;

  Perfil({
    required this.cedula,
    required this.vision,
    required this.carrera,
    required this.objetivo,
    required this.hojaVida,
  });

  // Método para serializar el objeto a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'cedula': cedula,
      'vision': vision,
      'carrera': carrera,
      'objetivo': objetivo,
      'hojaVida': hojaVida,
    };
  }

  // Método para crear un objeto desde un mapa (JSON)
  factory Perfil.fromJson(Map<String, dynamic> json) {
    return Perfil(
      cedula: json['cedula'],
      vision: json['vision'],
      carrera: json['carrera'],
      objetivo: json['objetivo'],
      hojaVida: json['hojaVida'],
    );
  }
}