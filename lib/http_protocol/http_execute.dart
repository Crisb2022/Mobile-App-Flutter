import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pasantapp/http_protocol/request_error.dart';

import '../common/enumerations.dart';

class HTTPExecute {
  String url;
  String resource;
  Map<String, dynamic> params;
  Map<String, dynamic> queryParams;

  HTTPExecute({required this.url , required this.resource, this.params = const {}, this.queryParams = const {}});

  get endPoint => (queryParams.isNotEmpty) ? Uri.http(url, resource, queryParams) : Uri.parse(url + resource);

  checkConnection(HTTPMethod httpMethod) async {
    final connection = await Connectivity().checkConnectivity();

    if (connection == ConnectivityResult.none) {
      return RequestError(TypeRequestError.connectionError).getRequestError();
    } else {
      return await executeMethod(httpMethod);
    }

  }

  executeMethod(HTTPMethod httpMethod) async {

    Response response;

    switch (httpMethod) {
      case HTTPMethod.GET:
        response = await http.get(endPoint, headers: headers);
      case HTTPMethod.GETINFO:
        response = await http.get(endPoint, headers: headers);
      case HTTPMethod.POST:
        response = await http.post(endPoint, headers: headers, body: encodedParams);
      case HTTPMethod.PUT:
        response = await http.put(endPoint, headers: headers, body: encodedParams);
      case HTTPMethod.DELETE:
        response = await http.delete(endPoint, headers: headers, body: encodedParams);
    }

    return validateResponse(response);

  }

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  String get encodedParams => jsonEncode(params);

  validateResponse(Response response) {
    return (response.statusCode >= 200 && response.statusCode < 300)?
       jsonDecode(response.body): RequestError(TypeRequestError.serverError, response: response).getRequestError();
  }

  get() {
    return checkConnection(HTTPMethod.GET);
  }

  post() {
    return checkConnection(HTTPMethod.POST);
  }

  put() {
    return checkConnection(HTTPMethod.PUT);
  }

  delete() {
    return checkConnection(HTTPMethod.DELETE);
  }

}