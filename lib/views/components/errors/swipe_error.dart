import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwipeError extends StatelessWidget {

  String text;

  SwipeError(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
              text,
              style: const TextStyle(fontSize: 20, color: Color(0xFF232323))),
          const SizedBox(height: 20),
          const Icon(CupertinoIcons.wifi_slash, size: 50, color: Color(0xFF2A3EB0)),
          const Text(
              "Desliza para recargar",
              style: TextStyle(fontSize: 20, color: Color(0xFF232323))),
        ],
      )
    );
  }

}