

import '../common/validate_data.dart';
import '../http_protocol/resource_execute.dart';

class ChatbotModel {
  String message;
  String role;

  ChatbotModel({
    this.message = '',
    this.role = 'user'
  });

  toObject(Map<dynamic, dynamic> data) {
    Validate validate = Validate(data);
    return ChatbotModel(
      message: validate.checkKeyExists('content', ''),
      role: validate.checkKeyExists('role', '')
    );
  }

  @override
  String toString() {
    return 'ChatbotModel{message: $message}, role: $role';
  }

  getChatbotMessage(String message) async {
    var response = await ResourceExecute.getChatbotMessage(message);
    return Validate(response).hasRequetsErrorOrBody(toObject);
  }

  getChatbotRecomendacion(String message) async {
    var response = await ResourceExecute.getChatbotRecomendacion(message);
    return Validate(response).hasRequetsErrorOrBody(toObject);
  }
}