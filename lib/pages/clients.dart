import 'package:flutter/material.dart';
import 'package:sistema_de_venda/widgets/buttons.dart';
import 'package:sistema_de_venda/widgets/texts.dart';
import 'package:sistema_de_venda/pages/home.dart';
import 'package:sistema_de_venda/pages/users.dart';
import 'package:sistema_de_venda/pages/products.dart';
import 'package:sistema_de_venda/pages/sales.dart';
import 'package:sistema_de_venda/pages/forms/clients.form.dart';

class Client extends StatelessWidget {
  const Client({Key? key}) : super(key: key);

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

  Widget _buildBody(BuildContext context) {
    return ListView(
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
                    Texts("Clientes"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Buttons("Cadastrar", onPressed: () {
                      _click(context, FormClient());
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              child: Column(children: [
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Nome/Razão Social: Enzo Terra",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Email: enzoterra@email.com",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("CPF/CNPJ: 444.444.444-44",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Data de Nascimento: 08/08/2004",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "Endereço: Rua A, Bairro Y, São Miguel Arcanjo - SP",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Telefone: (15) 99999-9999",
                              textAlign: TextAlign.center)
                        ])),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            _click(context, const Client());
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            _click(context, const Client());
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ))
              ]),
            )),
        Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              child: Column(children: [
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Nome/Razão Social: Luiggi Amaral",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Email: luiggiamaral@email.com",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("CPF/CNPJ: 555.555.555-55",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Data de Nascimento: 13/04/2000",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Endereço: Rua X, Bairro W, Itapetininga - SP",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Telefone: (15) 99999-9999",
                              textAlign: TextAlign.center)
                        ])),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            _click(context, const Client());
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            _click(context, const Client());
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ))
              ]),
            )),
      ],
    );
  }

  void _click(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
}
