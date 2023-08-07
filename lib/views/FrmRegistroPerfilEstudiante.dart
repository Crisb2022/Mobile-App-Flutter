import 'package:flutter/material.dart';

void main() {
  runApp(FrmPerfilEstudiant());
}

class FrmPerfilEstudiant extends StatelessWidget {
  static const routeName = '/signup-profile-students';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController _objetivosController = TextEditingController();
  TextEditingController _visionController = TextEditingController();
  TextEditingController _pasatiemposController = TextEditingController();
  TextEditingController _habilidadesController = TextEditingController();
  bool _trabajarEnEquipo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mi Formulario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _objetivosController,
              decoration: InputDecoration(labelText: 'Objetivos'),
            ),
            TextField(
              controller: _visionController,
              decoration: InputDecoration(labelText: 'Visión'),
            ),
            TextField(
              controller: _pasatiemposController,
              decoration: InputDecoration(labelText: 'Pasatiempos'),
            ),
            TextField(
              controller: _habilidadesController,
              decoration: InputDecoration(labelText: 'Habilidades'),
            ),
            CheckboxListTile(
              title: Text('¿Le gusta trabajar en equipo?'),
              value: _trabajarEnEquipo,
              onChanged: (newValue) {
                setState(() {
                  _trabajarEnEquipo = true;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Implementar la lógica para subir la hoja de vida
              },
              child: Text('Subir Hoja de Vida'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implementar la lógica para registrar los datos en la BD
              },
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
