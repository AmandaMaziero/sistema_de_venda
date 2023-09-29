import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Input extends StatelessWidget {
  String name;
  String label;
  bool isPassword;
  TextEditingController controller;

  Input(this.name, this.label, this.isPassword, {super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(
          color: Colors.black,
      ),
      decoration: InputDecoration (
          labelText: label,
          hintText: name
      )
    );
  }
}


