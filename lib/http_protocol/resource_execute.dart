import '../common/constants/url_constants.dart';
import 'http_execute.dart';

class ResourceExecute {

  // Obtiene todas las pasantías
  static getInternships() => HTTPExecute(url: urlScrap, resource: internshipsResource).get();

  // Obtiene una pasantía para información detallada
  static getInternshipInfo(int interID) => HTTPExecute(url: urlScrap, resource: internshipInfoResource + interID.toString()).get();

  // Conexion con el chatbot
  static getChatbotMessage(String message) => HTTPExecute(url: urlChat, resource: chatbotResource, params: {"message": message}).post();

}