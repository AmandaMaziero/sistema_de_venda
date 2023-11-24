import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistema_de_venda/widgets/texts.dart';
import 'package:sistema_de_venda/pages/users.dart';
import 'package:sistema_de_venda/pages/clients.dart';
import 'package:sistema_de_venda/pages/products.dart';
import 'package:sistema_de_venda/pages/sales.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
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
    return ListView(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Texts("Dashboard"),
        ),
        FutureBuilder<int>(
          future: countProducts(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro ao carregar dados: ${snapshot.error}');
            } else {
              int productCount = snapshot.data ?? 0;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.shopping_basket),
                        title: Text("Quantidade de Vendas: $productCount"),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
        FutureBuilder<double>(
          future: calculateTotalSales(),
          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            if (snapshot.hasError) {
              return Text('Erro ao carregar dados: ${snapshot.error}');
            } else {
              double totalSales = snapshot.data ?? 0;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.monetization_on_rounded),
                        title:
                            Text("Valor Total das Vendas: $totalSales reais"),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
        FutureBuilder<double>(
          future: calculateTotalCommissions(),
          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            if (snapshot.hasError) {
              return Text('Erro ao carregar dados: ${snapshot.error}');
            } else {
              double totalCommisions = snapshot.data ?? 0.00;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.money),
                        title:
                            Text("Valor das Comissões: $totalCommisions reais"),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }

  void _click(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  Future<int> countProducts() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('sales').get();

      return snapshot.docs.length;
    } catch (e) {
      print('Erro ao contar produtos: $e');
      return 0;
    }
  }

  Future<double> calculateTotalSales() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('sales').get();

      double totalSales = 0.0;
      for (var doc in snapshot.docs) {
        if (doc.exists && doc.data() != null) {
          Map<Object, dynamic>? data = doc.data() as Map<Object, dynamic>?;
          if (data != null && data.containsKey('totalValue')) {
            totalSales += data['totalValue'] ?? 0.0;
          }
        }
      }

      return totalSales;
    } catch (e) {
      print('Erro ao calcular total de vendas: $e');
      return 0.0;
    }
  }

  Future<double> calculateTotalCommissions() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('sales').get();

      double totalCommisions = 0.0;
      for (var doc in snapshot.docs) {
        if (doc.exists && doc.data() != null) {
          Map<Object, dynamic>? data = doc.data() as Map<Object, dynamic>?;
          if (data != null && data.containsKey('commission')) {
            totalCommisions += data['commission'] ?? 0.0;
          }
        }
      }

      return totalCommisions;
    } catch (e) {
      print('Erro ao calcular total de comissões: $e');
      return 0.0;
    }
  }
}
