// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pasantapp/db/Estudiantes.dart';
import 'package:pasantapp/views/FrmBottomMenuBar.dart';
import 'package:pasantapp/views/FrmRegistroPerfilEstudiante.dart';

class EstudiantesServices with ChangeNotifier {
  String message = '';
  List<int> data = [];

  // Registro del usuario en la base de datos
  Future signup(String nombres, String apellidos, String cedula, String correo,
      String usuario, String password, String image, String nacimiento, context) async {
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
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(json));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => FrmPerfilEstudiant()));
    } catch (e) {
      print(e);
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://127.0.0.1:5000/api/estudiantes/add');
    final response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    print(json.decode(response.body));
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://127.0.0.1:5000/api/estudiantes/login/cris2007/1234'); // Reemplaza con la URL de tu servidor Flask
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      message = jsonResponse['message'];
      data = List<int>.from(jsonResponse['data']);
    } else {
      message = 'Error al obtener los datos';
    }
  }
}
