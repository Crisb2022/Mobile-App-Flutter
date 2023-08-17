

import '../common/validate_data.dart';
import '../http_protocol/resource_execute.dart';

class IntershipsModel {

  int id;
  String empresa;
  String fecha;
  String lugar;
  String modalidad;
  String puesto;
  String link;

  IntershipsModel({
    this.id = 0,
    this.empresa = '',
    this.fecha = '',
    this.lugar = '',
    this.modalidad = '',
    this.puesto = '',
    this.link = '',
  });


  @override
  String toString() {
    return 'IntershipsModel{id: $id, empresa: $empresa}';
  }

  toObject(Map<dynamic, dynamic> data) {
    Validate validate = Validate(data);
    return IntershipsModel(
      id: validate.checkKeyExists('id', 0),
      empresa: validate.checkKeyExists('empresa', ''),
      fecha: validate.checkKeyExists('fecha', ''),
      lugar: validate.checkKeyExists('lugar', ''),
      modalidad: validate.checkKeyExists('modalidad', ''),
      puesto: validate.checkKeyExists('puesto', ''),
      link: validate.checkKeyExists('link', ''),
    );
  }

  getInterships() async {
    var response = await ResourceExecute.getInternships();
    return response;
    // return Validate(response).hasRequetsErrorOrBody(getListObject);
  }

  getListObject(data) {
    return (data as List).map((e) => toObject(e)).toList();
  }

}