import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pasantapp/utils/ImageSignUp.dart';
import 'package:pasantapp/views/registro/FrmLoginScreen.dart';
import 'package:pasantapp/views/registro/FrmTecnologias.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  static const routeName = '/feed-profile-screen';

  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> pasantiaInfo = {};
  String username = '';

  @override
  void initState() {
    super.initState();
    getPasantias();
  }

  Future<Map<String, String>> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString('username') ?? '',
      'userId': prefs.getString('cedula') ?? '',
      'nombres': prefs.getString('nombres') ?? '',
      'apellidos': prefs.getString('apellidos') ?? '',
      'correo': prefs.getString('correo') ?? '',
      'nacimiento': prefs.getString('nacimiento') ?? '',
      'cedula': prefs.getString('cedula') ?? '',
    };
  }

  Future<void> getPasantias() async {
    Map<String, String> userData = await _loadUserData();
    String cedula = userData['cedula'] ?? '';

    var urlCasa = 'http://192.168.100.240:7001/estudiantes/perfil/$cedula';
    final response = await http.get(Uri.parse(urlCasa));
    if (response.statusCode == 200) {
      setState(() {
        pasantiaInfo = Map<String, dynamic>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  void _cerrarSesion(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
  }

  void _abrirNuevaPagina(BuildContext context) {
    // Aquí puedes colocar la navegación a la nueva página
    // Por ejemplo:
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FrmTecnologias(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _loadUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        Map<String, String> userData = snapshot.data ?? {};
        username = userData['username'] ?? '';
        String userId = userData['userId'] ?? '';
        String nombres = userData['nombres'] ?? '';
        String apellidos = userData['apellidos'] ?? '';
        String correo = userData['correo'] ?? '';
        String nacimiento = userData['nacimiento'] ?? '';
        String cedula = userData['cedula'] ?? '';

        return Scaffold(
          appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 72, 127, 153),
        title: const Text(''),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.paste_rounded), // Cambia el icono por el que desees
          onPressed: () => _abrirNuevaPagina(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _cerrarSesion(context),
          ),
        ],
      ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _TopPortion(base64ImageData: "${pasantiaInfo['image']}"),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$nombres $apellidos',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton.extended(
                            onPressed: () {},
                            heroTag: 'follow',
                            elevation: 0,
                            backgroundColor: Color.fromARGB(255, 82, 61, 118),
                            label: const Text("GitHub"),
                            icon: const Icon(Icons.g_mobiledata_outlined),
                          ),
                          const SizedBox(width: 16.0),
                          FloatingActionButton.extended(
                            onPressed: () {},
                            heroTag: 'message',
                            elevation: 0,
                            backgroundColor: Colors.blue,
                            label: const Text("Facebook"),
                            icon: const Icon(Icons.facebook),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const _ProfileInfoRow(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Usuario: $username",
                                style:
                                    const TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.card_membership,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "ID: $userId",
                                style:
                                    const TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.email,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                correo,
                                style:
                                    const TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.cake,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                nacimiento,
                                style:
                                    const TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.book,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "${pasantiaInfo['carrera']}",
                                style:
                                    const TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.work,
                                color: Colors.grey,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${pasantiaInfo['objetivo']}",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.people,
                                color: Colors.grey,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${pasantiaInfo['vision']}",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Agrega aquí la lógica para mostrar el C.V
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              onPrimary: Colors.white,
                              textStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: Text("Ver C.V"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Posts", 900),
    ProfileInfoItem("Followers", 120),
    ProfileInfoItem("Following", 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
                  child: Row(
                    children: [
                      if (_items.indexOf(item) != 0) const VerticalDivider(),
                      Expanded(child: _singleItem(context, item)),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  final String? base64ImageData;

  const _TopPortion({Key? key, this.base64ImageData}) : super(key: key);

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
                  FutureBuilder<Uint8List?>(
                    future: ImageSignUp().decodeBase64(base64ImageData!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return Text('Error al decodificar la imagen');
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(snapshot.data!),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
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
