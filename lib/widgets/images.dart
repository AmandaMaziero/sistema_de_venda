import 'package:flutter/material.dart';
class Images extends StatefulWidget {
  final String path;
  const Images({Key? key, required this.path}) : super(key: key);

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
        widget.path,
        fit: BoxFit.cover,
        scale: 50,
    );
  }
}
