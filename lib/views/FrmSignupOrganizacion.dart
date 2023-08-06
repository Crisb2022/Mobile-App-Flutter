// ignore: file_names
import 'package:flutter/material.dart';
import 'package:pasantapp/services/OrganizacionService.dart';
import 'package:pasantapp/views/FrmBottomMenuBar.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignupOrganizacion extends StatelessWidget {
  static const routeName = '/signup-screen-org';

  final nombreController = TextEditingController();
  final direccionController = TextEditingController();
  final correoController = TextEditingController();
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();
  final telefonoController = TextEditingController();

  SignupOrganizacion({super.key});

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
            fit: BoxFit.fill,
            image: NetworkImage(
              'https://images.unsplash.com/photo-1557683316-973673baf926?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE4fHx8ZW58MHx8fHw%3D&w=1000&q=80',
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
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 50),
                          userInput(
                              nombreController, 'Nombre', TextInputType.text),
                          userInput(direccionController, 'Direccion',
                              TextInputType.text),
                          userInput(telefonoController, 'Telefono',
                              TextInputType.text),
                          userInput(
                              correoController, 'Correo', TextInputType.text),
                          userInput(
                              usuarioController, 'Usuario', TextInputType.text),
                          userInput(passwordController, 'Password',
                              TextInputType.text),
                          Container(
                            height: 60,
                            // Para replicar exactamente, elimina el padding.
                            padding: const EdgeInsets.only(
                                top: 5, left: 70, right: 70),
                            child: ElevatedButton(
                              onPressed: () {
                                Provider.of<OrganizacionServices>(context,
                                        listen: false)
                                    .signup(
                                        nombreController.text,
                                        telefonoController.text,
                                        correoController.text,
                                        direccionController.text,
                                        usuarioController.text,
                                        passwordController.text,
                                        context);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                backgroundColor: Colors.amber,
                              ),
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 100),
                          const SizedBox(height: 20),
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
