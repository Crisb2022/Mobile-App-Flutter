import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/validate_data.dart';
import '../../../http_protocol/request_error.dart';
import '../../../models/intershipsInfo_model.dart';

class IntershipInfo extends StatefulWidget {

  int id;
  String empresa;
  String puesto;

  IntershipInfo({required this.id, required this.empresa, required this.puesto});

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

    if(Validate.isNotRequestError(interships)) {
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
        body: isLoading ? const Center(child: CircularProgressIndicator(
          color: Color(0xFF2A3EB0),
        )) :
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: Column(
                                children: [
                                  Center(
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 140,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF2A3EB0),
                                                Color(0xBF00BE96),
                                                Color(0xFFF1EAEA)],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 60,
                                          left: 150,
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(300.0),
                                                border: Border.all(color: const Color(0xFF5B5959)),
                                                image: const DecorationImage(
                                                  image: AssetImage('assets/img/compania.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                widget.empresa,
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  "Puesto: ",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                Text(
                                  ' ${widget.puesto}',
                                  style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Descripción:",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              obj.descripcion,
                              style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFF484646))
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.location_city_sharp, size: 20, color: Color(0xFF2A3EB0)),
                                      Text(
                                          ' ${obj.modalidad}',
                                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black87)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(CupertinoIcons.cube, size: 20, color: Color(0xFF2A3EB0)),
                                      Text(
                                          ' ${obj.subarea}',
                                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black87)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time_sharp, size: 20, color: Color(0xFF2A3EB0)),
                                      Text(
                                          ' ${obj.tiempo}',
                                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black87)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.bookmark_border, size: 20, color: Color(0xFF2A3EB0)),
                                      Text(
                                          ' ${obj.oficio}',
                                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black87)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.person_2_outlined, size: 20, color: Color(0xFF2A3EB0)),
                                      Text(
                                          ' ${obj.disponibilidad}',
                                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black87)),
                                    ],
                                  ),
                                ]
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20, bottom: 20),
                              child: Center(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // TODO: Acción al presionar el botón
                                  },
                                  icon: const Icon(Icons.done_all, color: Colors.white,),
                                  label: const Text(
                                      'Postular',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFF1EAEA))
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2A3EB0),
                                    elevation: 7,
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                                  ),
                                ),
                              ) ,
                            ),
                          ],
                        )
                    )
                  ],
                )
              ]
            ),
          ),
        )
    );
  }

}
