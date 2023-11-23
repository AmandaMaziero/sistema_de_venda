import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistema_de_venda/services/product_service.dart';
import 'package:sistema_de_venda/widgets/buttons.dart';
import 'package:sistema_de_venda/widgets/input.dart';
import 'package:sistema_de_venda/widgets/texts.dart';
import 'package:sistema_de_venda/pages/home.dart';
import 'package:sistema_de_venda/pages/users.dart';
import 'package:sistema_de_venda/pages/clients.dart';
import 'package:sistema_de_venda/pages/products.dart';
import 'package:sistema_de_venda/pages/sales.dart';

class FormProduct extends StatefulWidget {
  final String? proId;
  const FormProduct({Key? key, this.proId}) : super(key: key);

  @override
  State<FormProduct> createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _code = TextEditingController();
  final _quantity = TextEditingController();
  final ProductService _productService = ProductService();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
            _buildDrawerItem('Vendas', const Sale(), context),
          ],
        ),
      ),
      body: _buildBody(context, proId: widget.proId),
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

  Widget _buildBody(BuildContext context, {String? proId}) {
    if (proId != null) {
      loadProductData(proId);
    }
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: proId != null
            ? Texts("Edição de Produtos")
            : Texts("Cadastro de Produtos"),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child:
            Input("Insira o nome...", "Nome:", controller: _name, false, true),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira a descrição...",
            "Descrição:",
            controller: _description,
            false,
            true),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira o preço...", "Preço:", controller: _price, false, true),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira o código de barras...",
            "Código de Barras:",
            controller: _code,
            false,
            true),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Input(
            "Insira a quantidade...",
            "Quantidade:",
            controller: _quantity,
            false,
            true),
      ),
      if (proId != null)
        Center(
          child: Column(
            children: [
              Buttons("Editar", onPressed: _editar),
            ],
          ),
        )
      else
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

  void loadProductData(String proId) async {
    try {
      var productSnapshot =
          await _firebaseFirestore.collection('products').doc(proId).get();

      if (productSnapshot.exists) {
        var clientData = productSnapshot.data() as Map<String, dynamic>;
        _name.text = clientData['name'] ?? '';
        _description.text = clientData['description'] ?? '';
        _price.text = clientData['price'].toString();
        _code.text = clientData['code'].toString();
        _quantity.text = clientData['quantity'].toString();
      }
    } catch (e) {
      print('Erro ao carregar dados do usuário: $e');
    }
  }

  void _cadastrar() {
    String description, price, code, quantity, name;
    setState(() {
      name = _name.text.toString();
      description = _description.text.toString();
      price = _price.text.toString();
      code = _code.text.toString();
      quantity = _quantity.text.toString();

      _productService
          .register(
        description: description,
        name: name,
        code: int.parse(code),
        price: double.parse(price),
        quantity: int.parse(quantity),
      )
          .then((error) {
        if (error == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Product()),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erro ao cadastrar produto!'),
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

  void _editar() {
    String description, price, code, quantity, name;
    setState(() {
      name = _name.text.toString();
      description = _description.text.toString();
      price = _price.text.toString();
      code = _code.text.toString();
      quantity = _quantity.text.toString();

      _productService
          .update(
        proId: widget.proId!,
        description: description,
        name: name,
        code: int.parse(code),
        price: double.parse(price),
        quantity: int.parse(quantity),
      )
          .then((error) {
        if (error == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Product()),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erro ao editar o produto!'),
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
