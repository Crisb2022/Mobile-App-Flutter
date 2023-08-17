import '../common/validate_data.dart';
import '../http_protocol/resource_execute.dart';

class IntershipsInfoModel {

  String descripcion;
  String modalidad;
  String subarea;
  String tiempo;
  String oficio;
  String disponibilidad;

  IntershipsInfoModel({
    this.descripcion = '',
    this.modalidad = '',
    this.subarea = '',
    this.tiempo = '',
    this.oficio = '',
    this.disponibilidad = '',
  });

  toObject(Map<dynamic, dynamic> data) {
    Validate validate = Validate(data);
    return IntershipsInfoModel(
      descripcion: validate.checkKeyExists('descripcion', ''),
      modalidad: validate.checkKeyExists('modalidad', ''),
      subarea: validate.checkKeyExists('subarea', ''),
      tiempo: validate.checkKeyExists('tiempo', ''),
      oficio: validate.checkKeyExists('oficio', ''),
      disponibilidad: validate.checkKeyExists('disponibilidad', ''),
    );
  }

  @override
  String toString() {
    return 'IntershipsInfo{modalidad: $modalidad, subarea: $subarea}';
  }

  getIntershipsInfo(int id) async {
    var response = await ResourceExecute.getInternshipInfo(id);
    return Validate(response).hasRequetsErrorOrBody(toObject);
  }

}