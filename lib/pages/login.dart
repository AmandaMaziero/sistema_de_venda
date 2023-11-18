import 'package:sistema_de_venda/pages/home.dart';
import 'package:sistema_de_venda/services/auth_service.dart';
import 'package:sistema_de_venda/widgets/buttons.dart';
import 'package:sistema_de_venda/widgets/input.dart';
import 'package:sistema_de_venda/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _cpf = TextEditingController();
  final _dateBirth = TextEditingController();
  final _type = TextEditingController();
  final _name = TextEditingController();
  final AuthService _authService = AuthService();
  bool naoPossuiCadastro = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistema de Venda"),
        backgroundColor: Colors.greenAccent,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Texts("Entre no sistema:"),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: naoPossuiCadastro,
                onChanged: (newValue) {
                  // Atualiza o estado da checkbox
                  setState(() {
                    naoPossuiCadastro = newValue!;
                  });
                },
              ),
              const Text("Não possui cadastro"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child:
              Input("Insira seu email...", "Email:", controller: _email, false),
        ),
        Visibility(
            visible: naoPossuiCadastro,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Input(
                  "Insira seu nome...", "Nome:", controller: _name, false),
            )),
        Visibility(
            visible: naoPossuiCadastro,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child:
                  Input("Insira seu CPF...", "CPF:", controller: _cpf, false),
            )),
        Visibility(
            visible: naoPossuiCadastro,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                  controller: _dateBirth,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                      labelText: "Data de Nascimento",
                      icon: Icon(Icons.calendar_today)),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        _dateBirth.text = formattedDate;
                      });
                    }
                  }),
            )),
        Visibility(
            visible: naoPossuiCadastro,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Input(
                  "Insira seu tipo...", "Tipo:", controller: _type, false),
            )),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Input(
              "Insira sua senha...", "Senha:", controller: _password, true),
        ),
        Center(
          child: Column(
            children: [
              Buttons("Entrar", onPressed: _entrar),
            ],
          ),
        ),
      ],
    );
  }

  void _entrar() {
    String email, password, cpf, type, birthDate, name;
    setState(() {
      email = _email.text.toString();
      password = _password.text.toString();
      name = _name.text.toString();
      cpf = _cpf.text.toString();
      type = _type.text.toString();
      birthDate = _dateBirth.text.toString();

      if (naoPossuiCadastro) {
        _authService
            .register(
          email: email,
          password: password,
          name: name,
          cpf: cpf,
          birthDate: DateTime.parse(birthDate),
          type: type,
        )
            .then((error) {
          if (error == null) {
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
                  content: Text(error),
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
      } else {
        _authService.login(email: email, password: password).then((error) {
          if (error == null) {
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
                  content: Text(error),
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
    });
  }
}
