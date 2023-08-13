class Pasantia {
  String idPasantia;
  String horasRequeridas;
  String modalidad;
  String remunerado;
  String detalle;
  String imagen;

  Pasantia({
    required this.idPasantia,
    required this.horasRequeridas,
    required this.modalidad,
    required this.remunerado,
    required this.detalle,
    required this.imagen,
  });

  factory Pasantia.fromJson(Map<String, dynamic> json) {
    return Pasantia(
      idPasantia: json['id_pasantia'],
      horasRequeridas: json['horas_requeridas'],
      modalidad: json['modalidad'],
      remunerado: json['remunerado'],
      detalle: json['detalle'],
      imagen: json['imagen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pasantia': idPasantia,
      'horas_requeridas': horasRequeridas,
      'modalidad': modalidad,
      'remunerado': remunerado,
      'detalle': detalle,
      'imagen': imagen,
    };
  }
}
