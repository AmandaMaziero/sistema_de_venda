import 'package:flutter/material.dart';
import 'package:sistema_de_venda/pages/forms/users.form.dart';
import 'package:sistema_de_venda/widgets/buttons.dart';
import 'package:sistema_de_venda/widgets/texts.dart';
import 'package:sistema_de_venda/pages/home.dart';
import 'package:sistema_de_venda/pages/clients.dart';
import 'package:sistema_de_venda/pages/products.dart';
import 'package:sistema_de_venda/pages/sales.dart';

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

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
                    Texts("Usuários"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Buttons("Cadastrar", onPressed: () {
                      _click(context, const FormUser());
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
                          Text("Nome: Amanda Maziero",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Email: amanda.maziero@empresa.com.br",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("CPF: 444.444.444-44",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Data de Nascimento: 10/06/2002",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tipo: ADMINISTRADOR",
                              textAlign: TextAlign.center)
                        ])),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            _click(context, const User());
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            _click(context, const User());
                          },
                          icon: const Icon(Icons.check),
                        ),
                        IconButton(
                          onPressed: () {
                            _click(context, const User());
                          },
                          icon: const Icon(Icons.delete),
                        )
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
                          Text("Nome: Caroline Amancio",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Email: caroline.amancio@empresa.com.br",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("CPF: 555.555.555-55",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Data de Nascimento: 15/10/2002",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tipo: ADMINISTRADOR",
                              textAlign: TextAlign.center)
                        ])),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            _click(context, const User());
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            _click(context, const User());
                          },
                          icon: const Icon(Icons.check),
                        ),
                        IconButton(
                          onPressed: () {
                            _click(context, const User());
                          },
                          icon: const Icon(Icons.delete),
                        )
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
                          Text("Nome: Gustavo Proença",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Email: gustavo.proenca@empresa.com.br",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("CPF: 111.111.111-11",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Data de Nascimento: 10/11/2002",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tipo: VENDEDOR", textAlign: TextAlign.center)
                        ])),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            _click(context, const User());
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            _click(context, const User());
                          },
                          icon: const Icon(Icons.check),
                        ),
                        IconButton(
                          onPressed: () {
                            _click(context, const User());
                          },
                          icon: const Icon(Icons.delete),
                        )
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
                          Text("Nome: Mariana Fernandes",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Email: mariana.fernandes@empresa.com.br",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("CPF: 111.111.111-11",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Data de Nascimento: 05/08/2003",
                              textAlign: TextAlign.center)
                        ])),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tipo: VENDEDOR", textAlign: TextAlign.center)
                        ])),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            _click(context, const User());
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            _click(context, const User());
                          },
                          icon: const Icon(Icons.check),
                        ),
                        IconButton(
                          onPressed: () {
                            _click(context, const User());
                          },
                          icon: const Icon(Icons.delete),
                        )
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
