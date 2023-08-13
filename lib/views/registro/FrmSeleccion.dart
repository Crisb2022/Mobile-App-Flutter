import 'package:flutter/material.dart';
import 'package:pasantapp/views/registro/FrmRegistroEST.dart';
import 'package:pasantapp/views/registro/FrmRegistroORG.dart';

class FrmSelectionUser extends StatelessWidget {
  static const routeName = '/frm-selection';
  const FrmSelectionUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la barra de depuración en la esquina superior derecha
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Barra superior oculta
        backgroundColor: Colors.amber,
        title: const  Text('Selecciona una categoria'),
        elevation: 5,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BotonOrganizacion(),
              SizedBox(height: 20),
              BotonEstudiante(),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true, // Permite extender el cuerpo del widget detrás de la barra superior
    );
  }
}

class BotonOrganizacion extends StatelessWidget {
  const BotonOrganizacion({super.key});

  @override
Widget build(BuildContext context) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupOrganizacion()));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const SizedBox(
              width: 250, // Cambia estos valores según tus necesidades
              height: 250,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/cargando.gif'),
                image: AssetImage('assets/images/organizacionBtn.webp'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}

class BotonEstudiante extends StatelessWidget {
  const BotonEstudiante({super.key});

  @override
Widget build(BuildContext context) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupEstudiante()));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const SizedBox(
              width: 250, // Cambia estos valores según tus necesidades
              height: 250,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/cargando.gif'),
                image: AssetImage('assets/images/estudiantesBtn.webp'),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  }
}
