class Tecnologia {
  int idTecnologia;
  String nombre;
  String descripcion;

  Tecnologia({required this.idTecnologia, required this.nombre, required this.descripcion});

  factory Tecnologia.fromJson(Map<String, dynamic> json) {
    return Tecnologia(
      idTecnologia: json['id_tecnologia'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_tecnologia': idTecnologia,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}
