
import '../http_protocol/request_error.dart';

class Validate {

  var data;

  Validate(this.data);

  checkKeyExists(String key, var valueDefault) {
    return (data.containsKey(key) && data[key] != null)? validateType(data[key], valueDefault) : valueDefault;
  }

  validateType(var value, var defaultValue) {
    switch(defaultValue.runtimeType) {
      case String:
        return value.toString();
      case int:
        return int.parse(value.toString());
      default:
        return value;
    }
  }

  hasRequetsErrorOrBody(var method) {
    return (data is RequestError) ? data : method(data);
  }

  static isNotRequestError(data) {
    return (data is! RequestError);
  }

}