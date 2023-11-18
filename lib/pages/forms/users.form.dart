import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistema_de_venda/services/auth_service.dart';
import 'package:sistema_de_venda/widgets/buttons.dart';
import 'package:sistema_de_venda/widgets/input.dart';
import 'package:sistema_de_venda/widgets/texts.dart';
import 'package:sistema_de_venda/pages/home.dart';
import 'package:sistema_de_venda/pages/users.dart';
import 'package:sistema_de_venda/pages/clients.dart';
import 'package:sistema_de_venda/pages/products.dart';
import 'package:sistema_de_venda/pages/sales.dart';

class FormUser extends StatefulWidget {
  const FormUser({super.key});

  @override
  State<FormUser> createState() => _FormUserState();
}

class _FormUserState extends State<FormUser> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _cpf = TextEditingController();
  final _dateBirth = TextEditingController();
  final _type = TextEditingController();
  final _password = TextEditingController();
  final AuthService _authService = AuthService();
  bool naoPossuiCadastro = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistema de Venda"),
        backgroundColor: Colors.greenAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
              ),
              child: Text('Sistema de Vendas'),
            ),
            _buildDrawerItem('Página Inicial', const Home(), context),
            _buildDrawerItem('Usuários', User(), context),
            _buildDrawerItem('Clientes', const Client(), context),
            _buildDrawerItem('Produtos', const Product(), context),
            _buildDrawerItem('Vendas', const Sale(), context),
          ],
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildDrawerItem(String title, Widget page, BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        _click(context, page);
      },
    );
  }

  @override
  void initState() {
    _dateBirth.text = ""; //set the initial value of text field
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Texts("Cadastro de Usuários"),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input("Insira seu nome...", "Nome:", controller: _name, false),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child:
            Input("Insira seu email...", "Email:", controller: _email, false),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input("Insira seu CPF...", "CPF:", controller: _cpf, false),
      ),
      Padding(
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
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input("Insira seu tipo...", "Tipo:", controller: _type, false),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child:
            Input("Insira sua senha...", "Senha:", controller: _password, true),
      ),
      Center(
        child: Column(
          children: [
            Buttons("Cadastrar", onPressed: _cadastrar),
          ],
        ),
      ),
    ]);
  }

  void _click(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  void _cadastrar() {
    String email, password, cpf, type, birthDate, name;
    setState(() {
      email = _email.text.toString();
      password = _password.text.toString();
      name = _name.text.toString();
      cpf = _cpf.text.toString();
      type = _type.text.toString();
      birthDate = _dateBirth.text.toString();

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
            MaterialPageRoute(builder: (context) => User()),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erro ao cadastrar usuário!'),
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
    });
  }
}
