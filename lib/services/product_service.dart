// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> register({
    required String name,
    required String description,
    required double price,
    required int code,
    required int quantity,
  }) async {
    try {
      DocumentReference documentReference =
          await _firebaseFirestore.collection('products').add({
        'name': name,
        'description': description,
        'price': price,
        'code': code,
        'quantity': quantity,
        'status': true
      });

      String documentId = documentReference.id;

      await documentReference.update({'uid': documentId});

      return null;
    } catch (e) {
      return "Erro ao cadastrar: $e";
    }
  }

  Future<String?> delete(String proId) async {
    try {
      await _firebaseFirestore.collection('products').doc(proId).delete();
      return null;
    } catch (e) {
      print("Erro ao deletar: $e");
      return "Erro ao deletar: $e";
    }
  }

  Future<String?> update(
      {required String proId,
      required String name,
      required String description,
      required double price,
      required int code,
      required int quantity}) async {
    try {
      await _firebaseFirestore.collection('products').doc(proId).update({
        'name': name,
        'description': description,
        'price': price,
        'code': code,
        'quantity': quantity
      });
      return null;
    } catch (e) {
      return "Erro ao editar: $e";
    }
  }

  Future<String?> changeStatus(
      {required String proId, required bool status}) async {
    try {
      await _firebaseFirestore
          .collection('products')
          .doc(proId)
          .update({'status': !status});
      return null;
    } catch (e) {
      return "Erro ao alterar status: $e";
    }
  }
}
