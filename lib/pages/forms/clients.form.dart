import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistema_de_venda/widgets/input.dart';
import 'package:sistema_de_venda/widgets/texts.dart';
import 'package:sistema_de_venda/pages/home.dart';
import 'package:sistema_de_venda/pages/users.dart';
import 'package:sistema_de_venda/pages/clients.dart';
import 'package:sistema_de_venda/pages/products.dart';
import 'package:sistema_de_venda/pages/sales.dart';

class FormClient extends StatefulWidget {
  const FormClient({super.key});

  @override
  State<FormClient> createState() => _FormClientState();
}

class _FormClientState extends State<FormClient> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _document = TextEditingController();
  final _dateBirth = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();

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
        child: Texts("Cadastro de Clientes"),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira nome/razão social...",
            "Nome/Razão Social:",
            controller: _name,
            false),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child:
            Input("Insira seu email...", "Email:", controller: _email, false),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira seu CPF/CNPJ...",
            "CPF/CNPJ:",
            controller: _document,
            false),
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
        child: Input(
            "Insira seu endereço...", "Endereço:", controller: _address, false),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira seu telefone...", "Telefone:", controller: _phone, true),
      ),
    ]);
  }

  void _click(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
}
