import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FrmPerfil extends StatefulWidget {
  static const routeName = '/signup-screen-students';
  final String cedula;

  FrmPerfil({required this.cedula});

  @override
  _FrmPerfilState createState() => _FrmPerfilState();
}

class _FrmPerfilState extends State<FrmPerfil> {
  

  TextEditingController visionController = TextEditingController();
  TextEditingController carreraController = TextEditingController();
  TextEditingController objetivoController = TextEditingController();
  String? filePath;

  void _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir Información'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: visionController,
              decoration: InputDecoration(labelText: 'Visión'),
            ),
            TextField(
              controller: carreraController,
              decoration: InputDecoration(labelText: 'Carrera'),
            ),
            TextField(
              controller: objetivoController,
              decoration: InputDecoration(labelText: 'Objetivo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickPDF,
              child: Text('Subir Archivo PDF'),
            ),
            if (filePath != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Archivo seleccionado: $filePath'),
              ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes implementar la lógica para enviar la información y el archivo a donde corresponda
              },
              child: Text('Guardar Información'),
            ),
          ],
        ),
      ),
    );
  }
}