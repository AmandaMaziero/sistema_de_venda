// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class ClientService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> register({
    required String name,
    required String email,
    required String document,
    required DateTime birthDate,
    required String address,
    required String phone,
  }) async {
    try {
      await _firebaseFirestore.collection('clients').add({
        'name': name,
        'email': email,
        'document': document,
        'birthDate': birthDate,
        'address': address,
        'phone': phone,
      });

      return null;
    } catch (e) {
      return "Erro ao cadastrar: $e";
    }
  }

  Future<String?> delete(String cliId) async {
    try {
      await _firebaseFirestore.collection('clients').doc(cliId).delete();
      return null;
    } catch (e) {
      print("Erro ao deletar: $e");
      return "Erro ao deletar: $e";
    }
  }

  Future<String?> update(
      {required String cliId,
      required String email,
      required String name,
      required String address,
      required String phone}) async {
    try {
      await _firebaseFirestore.collection('clients').doc(cliId).update(
          {'name': name, 'email': email, 'address': address, 'phone': phone});
      return null;
    } catch (e) {
      return "Erro ao editar: $e";
    }
  }

  Future<String?> changeStatus(
      {required String cliId, required bool status}) async {
    try {
      await _firebaseFirestore
          .collection('clients')
          .doc(cliId)
          .update({'status': !status});
      return null;
    } catch (e) {
      return "Erro ao alterar status: $e";
    }
  }
}
