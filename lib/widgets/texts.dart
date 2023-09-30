import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Texts extends StatelessWidget {
  String myText;

  Texts(this.myText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      myText,
      style: const TextStyle(color: Colors.black, fontSize: 20),
    );
  }
}
