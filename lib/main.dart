import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasantapp/services/FeedServices.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EstudiantesServices()),
        ChangeNotifierProvider(create: (_) => FeedServices()), // Agrega este provider
      ],
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
          FrmTecnologias.routeName: (context) => FrmTecnologias(),
          FrmIntroduccion.routeName: (context) => FrmIntroduccion(
            pages: [
              // Aquí debes definir las páginas para la introducción
              OnboardingPageModel(
                title: "Chat-GPT",
                description: "Responde tus inquietudes",
                image: "assets/images/tile_1.png",
                bgColor: const Color(0xFF1d447b),
                textColor: Colors.white,
              ),
              OnboardingPageModel(
                title: "Al día",
                description: "Pasantías actualizadas al momento",
                image: "assets/images/tile_2.png",
                bgColor: const Color(0xFF2A3EB0),
                textColor: Colors.white,
              ),
              OnboardingPageModel(
                title: "De estudiantes",
                description: "Para estudiantes",
                image: "assets/images/tile_3.png",
                bgColor: const Color.fromARGB(255, 50, 114, 205),
                textColor: Colors.white,
              ),
            ],
          ),
       },
      ),
    );
  }
}