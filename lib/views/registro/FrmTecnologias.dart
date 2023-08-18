import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pasantapp/common/validate_data.dart';
import 'dart:convert';

import 'package:pasantapp/models/chatbot_model.dart';

class FrmTecnologias extends StatefulWidget {
  static const routeName = '/signup-profile-screen';

  @override
  _FrmTecnologiasState createState() => _FrmTecnologiasState();
}

class _FrmTecnologiasState extends State<FrmTecnologias> {
  List<Map<String, dynamic>> tecnologias = [];
  List<String> tecnologiasSeleccionadas = [];
  String _responseChat = '';
  ChatbotModel _chatbotModel = ChatbotModel();

  Future<void> getTecnologias() async {
    var urlCasa = 'http://192.168.100.240:7001/estudiantes/tecnologias';
    final response = await http.get(Uri.parse(urlCasa));

    if (response.statusCode == 200) {
      setState(() {
        tecnologias =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  void handleTecnologiaTap(String tecnologiaNombre) {
    setState(() {
      if (tecnologiasSeleccionadas.contains(tecnologiaNombre)) {
        tecnologiasSeleccionadas.remove(tecnologiaNombre);
      } else {
        tecnologiasSeleccionadas.add(tecnologiaNombre);
      }
    });
  }

  void mostrarTecnologiasSeleccionadas() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 1000,
          child: Column(
            children: [
              const Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Tus habilidades:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tecnologiasSeleccionadas.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text( _responseChat),
                    );
                  },
                ),
              ),
              
              ElevatedButton(
                onPressed: () {
                  responseChatAi(tecnologiasSeleccionadas.join(', '));
                  Navigator.pop(context);
                },
                child: Text("Cerrar"),
              ),
            ],
          ),
        );
      },
    );
  }

  void responseChatAi(String mensaje) async {
    var chatMessage = await ChatbotModel().getChatbotRecomendacion(mensaje);
    (Validate.isNotRequestError(chatMessage))
        ? {
            _chatbotModel = chatMessage,
            setState(() {
              _responseChat = _chatbotModel.message;
            }),
            print(_chatbotModel.message)
          }
        : _chatbotModel = ChatbotModel();
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
        title: const Text('Habilidades'),
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
            final tecnologiaNombre = tecnologia['nombre'] as String;
            final tecnologiaDescripcion = tecnologia['descripcion'] as String;
            final tecnologiaSeleccionada =
                tecnologiasSeleccionadas.contains(tecnologiaNombre);

            return GestureDetector(
              onTap: () {
                handleTecnologiaTap(tecnologiaNombre);
              },
              child: Container(
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
                    tecnologiaNombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(tecnologiaDescripcion),
                  leading: Checkbox(
                    value: tecnologiaSeleccionada,
                    onChanged: (bool? value) {
                      handleTecnologiaTap(tecnologiaNombre);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: mostrarTecnologiasSeleccionadas,
        child: const Icon(Icons.catching_pokemon),
      ),
    );
  }
}
