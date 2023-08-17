import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pasantapp/services/EstudiantesService.dart';
import 'package:provider/provider.dart';

class FrmPerfil extends StatefulWidget {
  static const routeName = '/signup-screen-students';
  final String cedula;

  FrmPerfil({required this.cedula});

  @override
  _FrmPerfilState createState() => _FrmPerfilState();
}

class _FrmPerfilState extends State<FrmPerfil> {
  final visionController = TextEditingController();
  final carreraController = TextEditingController();
  final objetivoController = TextEditingController();
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

  Widget buildTextField(TextEditingController controller, String labelText,
      TextInputType inputType,
      {bool isMultiline = false}) {
    return Container(
      height: isMultiline ? null : 55,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        autocorrect: false,
        enableSuggestions: false,
        autofocus: false,
        keyboardType: inputType,
        maxLines: isMultiline ? null : 1,
        decoration: InputDecoration(
          hintText: labelText,
          hintStyle: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildElevatedButton(String text, Function onPressed,
      {Color? backgroundColor, IconData? icon}) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton.icon(
        onPressed: onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: backgroundColor ?? Colors.amber,
        ),
        icon: Icon(icon ?? Icons.upload_file),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Subir Información',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            buildTextField(visionController, 'Visión', TextInputType.text,
                isMultiline: true), // Make it multiline
            buildTextField(carreraController, 'Carrera', TextInputType.text),
            buildTextField(
              objetivoController,
              'Objetivo',
              TextInputType.multiline,
              isMultiline: true,
            ), // Make it multiline
            const SizedBox(height: 30),
            buildElevatedButton(
              'Subir Archivo PDF',
              _pickPDF,
              backgroundColor: Colors.amber,
            ),
            if (filePath != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Archivo seleccionado: $filePath'),
              ),
            const SizedBox(height: 30),
            buildElevatedButton(
              'Enviar Perfil',
              () {
                Provider.of<EstudiantesServices>(context, listen: false)
                    .signupPerfil(widget.cedula, visionController.text,
                        carreraController.text, objetivoController.text,'999', context);
              },
              backgroundColor: Colors.amber,
              icon: Icons.send,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
