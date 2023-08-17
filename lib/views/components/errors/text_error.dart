import 'package:flutter/cupertino.dart';

class TextError extends StatelessWidget {

  String text;

  TextError(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: const TextStyle(fontSize: 20, color: Color(0xFF2A3EB0)));
  }
}