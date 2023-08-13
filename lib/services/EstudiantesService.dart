// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pasantapp/db/Estudiantes.dart';
import 'package:pasantapp/views/registro/FrmTecnologias.dart';

class EstudiantesServices with ChangeNotifier {
  String message = '';
  List<int> data = [];

  // Registro del usuario en la base de datos
  Future signup(
      String nombres,
      String apellidos,
      String cedula,
      String correo,
      String usuario,
      String password,
      String image,
      String nacimiento,
      context) async {
    var data = Estudiantes(
        nombres: nombres,
        apellidos: apellidos,
        cedula: cedula,
        correo: correo,
        usuario: usuario,
        password: password,
        nacimiento: nacimiento,
        image: image);
    var json = data.toJson();
    try {
      // var urlCrisuni = 'http://10.119.204.196:7001/estudiantes';
      //  var urlCasa = 'http://192.168.100.240:7001/estudiantes';
      final url = Uri.parse('http://192.168.100.240:7001/estudiantes');
      // ignore: unused_local_variable
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(json));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => FrmPerfilEstudiantes()));
    } catch (e) {
      throw Exception('Error al cargar los datos: $e');
    }
  }

  Future<void> getTecnologias() async {
    var urlCasa = 'http://192.168.100.240:7001/estudiantes/tecnologias';
    final response = await http.get(Uri.parse(urlCasa));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
    } else {
      throw Exception('Error al cargar los datos');
    }
  }
}
