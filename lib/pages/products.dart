import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistema_de_venda/pages/forms/products.form.dart';
import 'package:sistema_de_venda/services/product_service.dart';
import 'package:sistema_de_venda/widgets/buttons.dart';
import 'package:sistema_de_venda/widgets/texts.dart';
import 'package:sistema_de_venda/pages/home.dart';
import 'package:sistema_de_venda/pages/users.dart';
import 'package:sistema_de_venda/pages/clients.dart';
import 'package:sistema_de_venda/pages/sales.dart';

class Product extends StatelessWidget {
  final ProductService _productService = ProductService();

  Product({super.key});
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Texts("Produtos"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Buttons("Cadastrar", onPressed: () {
                        _click(context, const FormProduct());
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
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

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Nenhum produto encontrado'));
        } else {
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final Map<String, dynamic> proData =
                  document.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  child: Column(
                    children: [
                      _buildTextRow("Id: ${proData['uid']}"),
                      _buildTextRow("Nome: ${proData['name']}"),
                      _buildTextRow("Descrição: ${proData['description']}"),
                      _buildTextRow("Preço: ${proData['price']}"),
                      _buildTextRow("Código de Barras: ${proData['code']}"),
                      _buildTextRow("Quantidade: ${proData['quantity']}"),
                      _buildTextRow("Status: ${proData['status']}"),
                      _buildIconButtons(
                          proData['uid'], proData['status'], context),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildTextRow(String text) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildIconButtons(id, status, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              _click(context, FormProduct(proId: id));
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              await _productService.changeStatus(proId: id, status: status);
            },
            icon: const Icon(Icons.check),
          ),
          IconButton(
            onPressed: () async {
              await _delete(id, context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  void _click(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  _delete(String id, BuildContext context) async {
    await _productService.delete(id).then((error) {
      if (error == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Deletado produto!'),
              content: const Text("Produto deletado com sucesso!"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro ao deletar!'),
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
}
