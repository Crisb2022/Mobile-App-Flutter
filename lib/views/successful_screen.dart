import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuccessfulScreen extends StatefulWidget {
  @override
  _SuccessfulScreenState createState() => _SuccessfulScreenState();
}

class _SuccessfulScreenState extends State<SuccessfulScreen> {
  String message = '';
  List<int> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://10.0.2.2:5000/api/estudiantes/login/cris2007/1234'); // Reemplaza con la URL de tu servidor Flask
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        message = jsonResponse['message'];
        data = List<int>.from(jsonResponse['data']);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => SuccessfulScreen()));
      });
    } else {
      setState(() {
        message = 'Error al obtener los datos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter + Flask'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message),
              if (data.isNotEmpty)
                ...data.map((item) => Text(item.toString())).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
