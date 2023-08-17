import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class ImageSignUp {

  final picker = ImagePicker();
  final VoidCallback? updateState;

  ImageSignUp({this.updateState});

  Dio dio = Dio();

  Future<File?> mostrarDialogo(BuildContext context) async {
    File? selectedImage;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    selectedImage = await selectImage(1);
                    
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tomar una foto',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(Icons.camera_alt, color: Colors.amber)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    selectedImage = await selectImage(2);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Seleccionar una foto',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(Icons.image, color: Colors.amber)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return selectedImage;
  }

Future<File?> selectImage(int op) async {
  var pickedFile;

  if (op == 1) {
    pickedFile = await picker.pickImage(source: ImageSource.camera);
  } else if (op == 2) {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
  }

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    String? base64Image = await getImageAsBase64(imageFile); // Llamada al método aquí
    if (base64Image != null) {
      // Aquí puedes hacer algo con el archivo de imagen y su representación en base64
    } else {
      // Manejo en caso de que no se pueda convertir la imagen a base64
    }
    return imageFile;
  } else {
    return File('/Aplicacion-PassApp/assets/images/cargando.gif');
  }
}

  Future<String?> getImageAsBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<Uint8List?> decodeBase64(String base64Image) async {
  try {
    print(base64Image);
    return base64Decode(base64Image);
  } catch (e) {
    print('Error decoding base64: $e');
    return null;
  }
}
}
