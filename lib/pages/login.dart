import 'package:sistema_de_venda/pages/home.dart';
import 'package:sistema_de_venda/widgets/buttons.dart';
import 'package:sistema_de_venda/widgets/input.dart';
import 'package:sistema_de_venda/widgets/texts.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistema de Venda"),
        backgroundColor: Colors.greenAccent,
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
          child: Texts("Entre no sistema:"),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Input("Email:", "Insira seu email...", controller: _email, false),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Input("Senha:", "Insira sua senha...", controller: _password, true),
        ),
        Center(
          child: Buttons("Entrar", onPressed: _entrar),
        )
      ],
    );
  }

  void _entrar() {
    String email, password;
    setState(() {
      email = _email.text.toString();
      password = _password.text.toString();

      if (email == "admin@admin.com" && password == "123456") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro ao entrar!'),
              content: const Text('Email ou Senha inválidos!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }
}
