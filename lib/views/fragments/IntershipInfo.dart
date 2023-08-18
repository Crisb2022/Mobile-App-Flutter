import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/validate_data.dart';
import '../../../http_protocol/request_error.dart';
import '../../../models/intershipsInfo_model.dart';

class IntershipInfo extends StatefulWidget {
  int id;
  String empresa;
  String puesto;

  IntershipInfo(
      {required this.id, required this.empresa, required this.puesto});

  @override
  State<IntershipInfo> createState() => _IntershipInfoState();
}

class _IntershipInfoState extends State<IntershipInfo> {
  bool isLoading = true;
  IntershipsInfoModel obj = IntershipsInfoModel();

  @override
  void initState() {
    super.initState();
    excuteMethods();
  }

  excuteMethods() async {
    print("ejecutando metodo info");
    var interships = await IntershipsInfoModel().getIntershipsInfo(widget.id);

    if (Validate.isNotRequestError(interships)) {
      obj = interships;
      setState(() {
        isLoading = false;
      });
      print("infoData loading");
    } else {
      RequestError error = interships as RequestError;
      print(error.messageError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 72, 127, 153),
          title: const Text('Multitrabajos', textAlign: TextAlign.center),
          elevation: 0,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Color(0xFF2A3EB0),
              ))
            : Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: ListView(children: [
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: const Column(
                                children: [
                                  Center(
                                    child: Stack(
                                      children: [_TopPortion()],
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                widget.empresa,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 50),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Puesto: ",
                                        style: TextStyle(
                                          fontSize: 18, 
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        ' ${widget.puesto}',
                                        style: const TextStyle(
                                          fontSize: 18, 
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Padding(
                              padding:  EdgeInsets.only(left: 20.0),
                              child:  Column(
                                children: [
                                   Text(
                                          "Descripción:",
                                          style: TextStyle(
                                            fontSize: 18, 
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text(
                                    obj.descripcion,
                                    style: const TextStyle(
                                      fontSize: 15, 
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildRow(
                                      Icons.location_city_sharp, obj.modalidad),
                                  const SizedBox(height: 8),
                                  _buildRow(CupertinoIcons.cube, obj.subarea),
                                  const SizedBox(height: 8),
                                  _buildRow(Icons.access_time_sharp, obj.tiempo),
                                  const SizedBox(height: 8),
                                  _buildRow(Icons.bookmark_border, obj.oficio),
                                  const SizedBox(height: 8),
                                  _buildRow(Icons.person_2_outlined,
                                      obj.disponibilidad),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // TODO: Acción al presionar el botón
                                  },
                                  icon: const Icon(
                                    Icons.done_all,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Postular',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2A3EB0),
                                    elevation: 7,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40,
                                        vertical:
                                            12), // Aumenta el valor horizontal para hacer el botón más largo
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                      ],
                    )
                  ]),
                ),
              ));
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minHeight: 100, maxHeight: 200), // Establece una altura mínima
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromARGB(255, 149, 198, 221),
                  Color.fromARGB(255, 72, 127, 153),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(0, 0, 0, 0),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/compania.png')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRow(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon,
          size: 24,
          color: const Color(0xFF2A3EB0)), // Tamaño del icono ajustado a 24
      const SizedBox(width: 10), // Espacio entre el icono y el texto
      Text(
        text,
        style: const TextStyle(
          fontSize: 18, // Tamaño del texto ajustado a 18
          fontWeight: FontWeight.normal,
          color: Colors.black87,
        ),
      ),
    ],
  );
}
