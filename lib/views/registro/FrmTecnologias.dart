import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FrmPerfilEstudiantes extends StatefulWidget {
  static const routeName = '/signup-profile-screen';

  @override
  _FrmPerfilEstudiantesState createState() => _FrmPerfilEstudiantesState();
}

class _FrmPerfilEstudiantesState extends State<FrmPerfilEstudiantes> {
  List<Map<String, dynamic>> tecnologias = [];

  Future<void> getTecnologias() async {
    var urlCasa = 'http://192.168.100.240:7001/estudiantes/tecnologias';
    final response = await http.get(Uri.parse(urlCasa));

    if (response.statusCode == 200) {
      setState(() {
        tecnologias = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  @override
  void initState() {
    super.initState();
    getTecnologias();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Lista de Tecnologías'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: tecnologias.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8);
        },
        itemBuilder: (BuildContext context, int index) {
          final tecnologia = tecnologias[index];
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                tecnologia['nombre'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(tecnologia['descripcion'] ?? ''),
              leading: Checkbox(
                value: tecnologia['selected'] ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    tecnologia['selected'] = value;
                  });
                },
              ),
              onTap: () {
                // Lógica al hacer clic en una tecnología
              },
            ),
          );
        },
      ),
    ),
  );
}
}