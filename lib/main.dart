import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasantapp/views/menu/FrmIntroduccion.dart';
import 'package:pasantapp/views/registro/FrmLoginScreen.dart';
import 'package:pasantapp/views/registro/FrmTecnologias.dart';
import 'package:provider/provider.dart';
import 'views/registro/FrmRegistroEST.dart';
import 'views/FrmWelcomeApp.dart';
import 'services/EstudiantesService.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => EstudiantesServices(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: FrmIntroduccion.routeName, // Agrega esta línea
        routes: {
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          SignupEstudiante.routeName: (context) => SignupEstudiante(),
          LoginScreen.routeName: (context) => LoginScreen(),
          FrmPerfilEstudiantes.routeName: (context) => FrmPerfilEstudiantes(),
          FrmIntroduccion.routeName: (context) => FrmIntroduccion(
            pages: [
              // Aquí debes definir las páginas para la introducción
              OnboardingPageModel(
                title: "Título 1",
                description: "Descripción 1",
                image: "assets/images/bd.webp",
                bgColor: Colors.blue,
                textColor: Colors.white,
              ),
              OnboardingPageModel(
                title: "Título 2",
                description: "Descripción 2",
                image: "assets/images/analista.webp",
                bgColor: Colors.red,
                textColor: Colors.white,
              ),
            ],
          ),
       },
      ),
    );
  }
}