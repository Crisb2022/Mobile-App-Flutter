import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
      return File(pickedFile.path);
    }else{
      return File('/Aplicacion-PassApp/assets/images/cargando.gif');
    }

    return null;
  }

  Future<void> subirImagen(File? imagen, String cedula)async{
    try {
      String fileName = imagen!.path.split('/').last;
      // ignore: unnecessary_new
      FormData formData = new FormData.fromMap({
        'idImagen': cedula,
        'file': await MultipartFile.fromFile(
          imagen.path, filename: fileName
        )
      });
      await dio.post('http://192.168.100.240:7001/estudiantes/image',
      data: formData).then((value) {
        if (value.toString() == '1') {
          print('ta posi papi');
        } else {
          print('Algo salio mal');
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

}
