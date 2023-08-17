class Postulacion {
  String idOrg;
  String idEstudiante;

  Postulacion({
    required this.idOrg,
    required this.idEstudiante,
  });

  Map<String, dynamic> toJson() {
    return {
      'idOrg': idOrg,
      'idEstudiante': idEstudiante,
    };
  }

  factory Postulacion.fromJson(Map<String, dynamic> json) {
    return Postulacion(
      idOrg: json['idOrg'],
      idEstudiante: json['idEstudiante'],
    );
  }
}