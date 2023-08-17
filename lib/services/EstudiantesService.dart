import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pasantapp/db/Estudiantes.dart';
import 'package:pasantapp/db/Perfil.dart';
import 'package:pasantapp/views/menu/FrmMenu.dart';
import 'package:pasantapp/views/registro/FrmLoginScreen.dart';
import 'package:pasantapp/views/registro/FrmPerfil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EstudiantesServices with ChangeNotifier {

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
      final url = Uri.parse('http://192.168.100.240:7001/estudiantes');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(json),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => FrmPerfil(cedula: cedula)));
      } else {
        // Error en la respuesta de la base de datos
        throw Exception(
            'Error en la respuesta de la base de datos: ${response.statusCode}');
      }
    } catch (e) {
      // Manejo de excepciones
      print('Error: $e');
      throw Exception('Error al cargar los datos');
    }
  }


  Future signupPerfil(
      String cedula,String vision,String carrera,String objetivo,String hojaVida,
      context) async {
    var data = Perfil(
        cedula: cedula,
        vision: vision,
        carrera: carrera,
        objetivo: objetivo,
        hojaVida: hojaVida);
    var json = data.toJson();
    try {
      final url = Uri.parse('http://192.168.100.240:7001/estudiantes/perfil');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(json),
      );

      print("--------------- "+cedula);
      if (response.statusCode == 200 || response.statusCode == 204) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
      } else {
        // Error en la respuesta de la base de datos
        throw Exception(
            'Error en la respuesta de la base de datos: ${response.statusCode}');
      }
    } catch (e) {
      // Manejo de excepciones
      print('Error: $e');
      throw Exception('Error al cargar los datos');
    }
  }

  Future<Map<String, dynamic>?> login(
      context, String username, String password) async {
    final url = Uri.parse(
        'http://192.168.100.240:7001/estudiantes/$username/$password');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Lista donde guarda el json
        final Map<String, dynamic> userInfo = json.decode(response.body);
        
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const FrmBottomMenuBar()));
        // Guardar los datos del usuario en shared_preferences
        await saveUserDataToSharedPreferences(username, 
        userInfo['cedula'].toString(), 
        userInfo['nombres'].toString(),
        userInfo['apellidos'].toString(),
        userInfo['correo'].toString(), 
        userInfo['nacimiento'].toString(), 
        userInfo['image'].toString());
        return userInfo;
      } else if (response.statusCode == 204) {
        await widgetError(context, "Usuario o contraseña erroneos");
        Navigator.popUntil(context, ModalRoute.withName('/'));
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
      }
    } catch (e) {
      await widgetError(context, "Error del servidor, inténtelo nuevamente");
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    }
    return null;
  }

  Future<void> widgetError(BuildContext context, String? leyenda) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.error_outline,
            size: 50,
            color: Colors.red,
          ),
          title: const Text(
            'Error de inicio de sesión',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: Text(
            '$leyenda',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text(
                'Cerrar',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          elevation: 5,
        );
      },
    );
  }

  Future<void> saveUserDataToSharedPreferences(String username,
   String cedula, 
   String nombres,
   String apellidos, 
   String correo, 
   String nacimiento, 
   String image ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('cedula', cedula);
    prefs.setString('nombres', nombres);
    prefs.setString('apellidos', apellidos);
    prefs.setString('correo', correo);
    prefs.setString('nacimiento', nacimiento);
    prefs.setString('image', image);
  }
}
