// ignore: file_names
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pasantapp/db/Organizacion.dart';

class OrganizacionServices with ChangeNotifier {

  String message = '';
  List<int> data = [];

  // Registro del usuario en la base de datos
  Future signup(
      String nombre,
      String telefono,
      String correo,
      String direccion,
      String usuario,
      String password
      ) async {
    var data = Organizacion(
        nombre: nombre,
        correo: correo,
        usuario: usuario,
        telefono: telefono,
        password: password,
        direccion: direccion);
    var json = data.toJson();
    try {
      final url = Uri.parse('http://192.168.100.240:7001/org');
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(json));
          print(jsonDecode(response.body));
    } catch (e) {
      print(e);
    }
  }

}