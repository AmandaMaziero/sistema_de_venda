import 'package:flutter/material.dart';
import 'package:sistema_de_venda/widgets/texts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistema de Venda"),
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(
              onPressed: () {
                _click(context, const Home());
              },
              icon: const Icon(Icons.home)
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Padding (
          padding: const EdgeInsets.all(20),
          child: Texts("Seja Bem-Vindo"),
        )
      ],
    );
    }

  _click(BuildContext context, page) {
    Navigator.push(context, MaterialPageRoute(builder:
        (BuildContext context) {
      return page;
    }
    ));
    }
  }