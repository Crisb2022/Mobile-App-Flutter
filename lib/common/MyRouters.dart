
import 'package:flutter/material.dart';

import '../views/fragments/Intership.dart';
import '../views/fragments/IntershipInfo.dart';



const String ROUTE_HOME = "/Navegation";
const String ROUTE_INTERSHIP = "/Intership";
const String ROUTE_INTERSHIPINFO = "/IntershipInfo";

class MyRouters {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_HOME:
        // return MaterialPageRoute(builder: (_) => Navegation());
      case ROUTE_INTERSHIP:
        return MaterialPageRoute(builder: (_) => Intership());
      case ROUTE_INTERSHIPINFO:
        return MaterialPageRoute(builder: (_) => IntershipInfo(id: 1, empresa: "", puesto: ""));
      default:
        return MaterialPageRoute(builder: (_) => settings.name != null ? Text('No route defined for ${settings.name}') : Text('No route defined'));
    }
  }
}