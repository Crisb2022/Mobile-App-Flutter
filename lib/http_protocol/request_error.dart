import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../common/enumerations.dart';
import '../views/components/errors/swipe_error.dart';
import '../views/components/errors/text_error.dart';

class RequestError {

  TypeRequestError type;
  Widget? swipeError;
  Widget? messageError;
  String message;
  Response? response;

  RequestError( this.type, {this.swipeError, this.messageError, this.message = "", this.response});

  getRequestError() {
    switch (type) {
      case TypeRequestError.connectionError:
        return getMessage("No hay conexión a internet");
      case TypeRequestError.serverError:
        return getMessage("Error en el servidor ${response!.statusCode}" );
      case TypeRequestError.messageError:
        return getMessage(message);
    }
  }

  getMessage(String message) {

    this.message = message;
    swipeError = SwipeError(message);
    messageError = TextError(message);
    return message;
  }

}