import 'package:flutter/material.dart';
import 'package:sistema_de_venda/services/sale_service.dart';
import 'package:sistema_de_venda/widgets/buttons.dart';
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
  final _totalValue = TextEditingController();
  final _products = TextEditingController();
  final _commission = TextEditingController();
  final _percentage = TextEditingController();
  final _paymentMethod = TextEditingController();
  final SaleService _saleService = SaleService();

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
            _buildDrawerItem('Clientes', Client(), context),
            _buildDrawerItem('Produtos', Product(), context),
            _buildDrawerItem('Vendas', Sale(), context),
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
            "Insira o Vendedor...",
            "Vendedor:",
            controller: _seller,
            false,
            true),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira o Cliente...",
            "Cliente:",
            controller: _client,
            false,
            true),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira o Valor Total...",
            "Valor Total:",
            controller: _totalValue,
            false,
            true),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira os Produtos...",
            "Produtos:",
            controller: _products,
            false,
            true),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira a comissão...",
            "Comissão:",
            controller: _commission,
            false,
            true),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira o percentual...",
            "Percentual:",
            controller: _percentage,
            false,
            true),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira a forma de pagamento...",
            "Forma de Pagamento:",
            controller: _paymentMethod,
            false,
            true),
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
    String seller,
        client,
        totalValue,
        products,
        commission,
        percentage,
        paymentMethod;
    setState(() {
      seller = _seller.text.toString();
      totalValue = _totalValue.text.toString();
      client = _client.text.toString();
      products = _products.text.toString();
      commission = _commission.text.toString();
      percentage = _percentage.text.toString();
      paymentMethod = _paymentMethod.text.toString();

      _saleService
          .register(
        totalValue: double.parse(totalValue),
        seller: seller,
        products: products,
        client: client,
        commission: double.parse(commission),
        percentage: double.parse(percentage),
        paymentMethod: paymentMethod,
      )
          .then((error) {
        if (error == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Sale()),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erro ao cadastrar venda!'),
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
