import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasantapp/views/FrmLoginScreen.dart';
import 'package:pasantapp/views/FrmSelectionUser.dart';
import 'package:pasantapp/views/FrmSignupOrganizacion.dart';
import 'package:provider/provider.dart';
import 'views/FrmSignupEstudiante.dart';
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
        home: WelcomeScreen(),
        routes: {
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          SignupEstudiante.routeName: (context) => SignupEstudiante(),
          SignupOrganizacion.routeName: (context) =>SignupOrganizacion(),
          LoginScreen.routeName: (context) => LoginScreen(),
          FrmSelectionUser.routeName: (context) => const FrmSelectionUser(),
        },
      ),
    );
  }
}


