// ignore: file_names
import 'package:flutter/material.dart';
import 'package:pasantapp/services/EstudiantesService.dart';
import 'package:pasantapp/utils/ImageSignUp.dart';
import 'package:provider/provider.dart';

import 'dart:io';

class SignupEstudiante extends StatefulWidget {
  static const routeName = '/signup-screen-students';

  @override
  _SignupEstudianteState createState() => _SignupEstudianteState();
}

class _SignupEstudianteState extends State<SignupEstudiante> {
  File? image;
  String? base64ImageData;

  final nombresController = TextEditingController();
  final apellidosController = TextEditingController();
  final cedulaController = TextEditingController();
  final correoController = TextEditingController();
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();
  final imageController = TextEditingController();
  final nacimientoController = TextEditingController();

  Widget signUpWith(IconData icon) {
    return Expanded(
      child: Container(
        height: 50,
        width: 115,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            TextButton(onPressed: () {}, child: const Text('Ingresar')),
          ],
        ),
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.contain,
            image: AssetImage(
              'assets/images/login.webp',
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              // Utilizar Expanded para que el SingleChildScrollView ocupe todo el espacio disponible
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 30),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Registro de datos',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1d587b)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          userInput(
                              nombresController, 'Nombre', TextInputType.text),
                          userInput(apellidosController, 'Apellido',
                              TextInputType.text),
                          userInput(nacimientoController, 'Fecha de nacimiento',
                              TextInputType.text),
                          userInput(
                              cedulaController, 'Cedula', TextInputType.text),
                          userInput(
                              correoController, 'Correo', TextInputType.text),
                          userInput(
                              usuarioController, 'Usuario', TextInputType.text),
                          userInput(passwordController, 'Password',
                              TextInputType.text),
                          Container(
                            // ----------------Camara-----------------
                            height: 60,
                            // Para replicar exactamente, elimina el padding.
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: ElevatedButton(
                              onPressed: () async {
                                ImageSignUp imageSignUp = ImageSignUp();
                                File? selectedImage =
                                    await imageSignUp.mostrarDialogo(context);

                                if (selectedImage != null) {
                                  String? base64Image = await imageSignUp
                                      .getImageAsBase64(selectedImage);

                                  if (base64Image != null) {
                                    setState(() {
                                      image = selectedImage;
                                      base64ImageData = base64Image; // Asigna la representación en base64
                                    });
                                  } else {
                                    // Manejo en caso de que no se pueda convertir la imagen a base64
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                backgroundColor:
                                    const Color(0xFF1d587b),
                              ),
                              child: const Text(
                                'Foto de perfil',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            // Mostrar la imagen seleccionada debajo del botón
                            child: image == null
                                ? const Center()
                                : Image.file(image!),
                          ),
                          const Divider(thickness: 0, color: Colors.white),
                          Container(
                            height: 60,
                            // Para replicar exactamente, elimina el padding.
                            padding: const EdgeInsets.only(
                                top: 5, left: 70, right: 70),
                            child: ElevatedButton(
                              onPressed: () {
                                Provider.of<EstudiantesServices>(context,
                                        listen: false)
                                    .signup(
                                        nombresController.text,
                                        apellidosController.text,
                                        cedulaController.text,
                                        correoController.text,
                                        usuarioController.text,
                                        passwordController.text,
                                        base64ImageData!,
                                        nacimientoController.text,
                                        context);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                backgroundColor: const Color(0xFF1d447b),
                              ),
                              child: const Text(
                                'Crear usuario',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Divider(thickness: 0, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
