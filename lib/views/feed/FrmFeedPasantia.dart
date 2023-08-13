import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pasantapp/views/feed/FrnInfoPasantia.dart';
import 'dart:convert';

import 'package:pasantapp/views/registro/FrmTecnologias.dart';

class FeedHome extends StatefulWidget {
  static const routeName = '/feed-one-screen';

  @override
  _FeedHomeState createState() => _FeedHomeState();
}

class _FeedHomeState extends State<FeedHome> {
  List<Map<String, dynamic>> pasantias = [];

  Future<void> getPasantias() async {
    var urlCasa = 'http://192.168.100.240:7001/estudiantes/feed';
    final response = await http.get(Uri.parse(urlCasa));
    if (response.statusCode == 200) {
      setState(() {
        pasantias = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  @override
  void initState() {
    super.initState();
    getPasantias(); // Llama al método automáticamente al abrir la ventana
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Barra superior oculta
        backgroundColor: const Color.fromARGB(255, 79, 153, 214),
        title: const Text('Cargando datos'),
        elevation: 5,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView.builder(
            itemCount: pasantias.length,
            itemBuilder: (BuildContext context, int index) {
              final pasantia = pasantias[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => FrmInfoPasantia(pasantia: pasantia,)));
                },
                child: Container(
                  height: 136,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pasantia['empresa'] ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                              "${pasantia['imagen']} · ${pasantia['horas_requeridas']}",
                              style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icons.bookmark_border_rounded,
                              Icons.person
                            ].map((e) {
                              return InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(e, size: 16),
                                ),
                              );
                            }).toList(),
                          )
                        ],
                      )),
                      Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/${pasantia['imagen']}.webp"),
                              ))),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
