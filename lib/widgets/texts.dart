import 'package:flutter/material.dart';

class Texts extends StatelessWidget {
  String myText;

  Texts(this.myText);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.myText,
      style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: "sans-serif"
      ),
    );
  }
}
