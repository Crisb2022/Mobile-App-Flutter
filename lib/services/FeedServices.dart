import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pasantapp/db/Posulacion.dart';
import 'package:pasantapp/views/menu/FrmMenu.dart';

class FeedServices with ChangeNotifier {

  Future<void> postulacionBody(String idOrg, String idEst, String empresa,context) async {
    var data = Postulacion(idOrg: idOrg, idEstudiante: idEst);
    var json = data.toJson();

    // Mostrar el diálogo de confirmación
    bool? shouldPost = await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Confirmación',
          content: '¿Deseas postular en $empresa?',
        );
      },
    );

    if (shouldPost == true) {
      try {
        final url = Uri.parse('http://192.168.100.240:7001/org/postulacion');
        var response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(json),
        );
        if (response.statusCode == 200 || response.statusCode == 204) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const FrmBottomMenuBar()));
        } else {
          throw Exception(
              'Error en la respuesta de la base de datos: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
        throw Exception('Error al cargar los datos');
      }
    }
  }

}

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;

  ConfirmationDialog({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // No postular
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Postular
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}


