import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Buttons extends StatelessWidget {
  String text;
  final void Function() onPressed;
  Buttons(this.text, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          foregroundColor: Colors.black,
          fixedSize: const Size(100, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0)),
          ),
          child: Text(text)
    );
  }
}
