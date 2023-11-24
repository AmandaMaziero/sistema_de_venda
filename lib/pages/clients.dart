import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistema_de_venda/pages/forms/clients.form.dart';
import 'package:sistema_de_venda/services/client_service.dart';
import 'package:sistema_de_venda/widgets/buttons.dart';
import 'package:sistema_de_venda/widgets/texts.dart';
import 'package:sistema_de_venda/pages/home.dart';
import 'package:sistema_de_venda/pages/users.dart';
import 'package:sistema_de_venda/pages/products.dart';
import 'package:sistema_de_venda/pages/sales.dart';

class Client extends StatelessWidget {
  final ClientService _clientService = ClientService();

  Client({super.key});
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
                        _click(context, const FormClient());
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
      stream: FirebaseFirestore.instance.collection('clients').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Nenhum cliente encontrado'));
        } else {
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final Map<String, dynamic> clientData =
                  document.data() as Map<String, dynamic>;
              final formattedBirthDate =
                  _formatBirthDate(clientData['birthDate']);
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  child: Column(
                    children: [
                      _buildTextRow("Id: ${clientData['uid']}"),
                      _buildTextRow("Nome: ${clientData['name']}"),
                      _buildTextRow("Email: ${clientData['email']}"),
                      _buildTextRow("CPF/CNPJ: ${clientData['document']}"),
                      _buildTextRow("Data de Nascimento: $formattedBirthDate"),
                      _buildTextRow("Endereço: ${clientData['address']}"),
                      _buildTextRow("Telefone: ${clientData['phone']}"),
                      _buildIconButtons(
                          clientData['uid'], clientData['status'], context),
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
              _click(context, FormClient(cliId: id));
            },
            icon: const Icon(Icons.edit),
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

  String _formatBirthDate(dynamic birthDate) {
    final timestamp = birthDate as Timestamp;
    final dateTime = timestamp.toDate();
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  _delete(String id, BuildContext context) async {
    await _clientService.delete(id).then((error) {
      if (error == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Deletado cliente!'),
              content: const Text("Cliente deletado com sucesso!"),
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
