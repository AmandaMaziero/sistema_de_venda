import 'package:flutter/material.dart';
import 'package:sistema_de_venda/widgets/input.dart';
import 'package:sistema_de_venda/widgets/texts.dart';
import 'package:sistema_de_venda/pages/home.dart';
import 'package:sistema_de_venda/pages/users.dart';
import 'package:sistema_de_venda/pages/clients.dart';
import 'package:sistema_de_venda/pages/products.dart';
import 'package:sistema_de_venda/pages/sales.dart';

class FormSale extends StatefulWidget {
  const FormSale({super.key});

  @override
  State<FormSale> createState() => _FormSaleState();
}

class _FormSaleState extends State<FormSale> {
  final _seller = TextEditingController();
  final _client = TextEditingController();
  final _amount = TextEditingController();
  final _products = TextEditingController();
  final _commission = TextEditingController();
  final _percentage = TextEditingController();
  final _paymentMethod = TextEditingController();

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
            _buildDrawerItem('Usuários', const User(), context),
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

  Widget _buildBody(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Texts("Cadastro de Vendas"),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira o Vendedor...", "Vendedor:", controller: _seller, false),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira o Cliente...", "Cliente:", controller: _client, false),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira o Valor Total...",
            "Valor Total:",
            controller: _amount,
            false),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira os Produtos...", "Produtos:", controller: _products, false),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira a comissão...", "Comissão:", controller: _commission, true),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira o percentual...",
            "Percentual:",
            controller: _percentage,
            true),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira a forma de pagamento...",
            "Forma de Pagamento:",
            controller: _paymentMethod,
            true),
      ),
    ]);
  }

  void _click(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
}
