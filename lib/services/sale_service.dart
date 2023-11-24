// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class SaleService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> register({
    required String seller,
    required String client,
    required double totalValue,
    required String products,
    required double commission,
    required double percentage,
    required String paymentMethod,
  }) async {
    try {
      DocumentReference documentReference =
          await _firebaseFirestore.collection('sales').add({
        'seller': seller,
        'client': client,
        'totalValue': totalValue,
        'products': products,
        'commission': commission,
        'percentage': percentage,
        'paymentMethod': paymentMethod,
        'status': true
      });

      String documentId = documentReference.id;

      await documentReference.update({'uid': documentId});

      return null;
    } catch (e) {
      return "Erro ao cadastrar: $e";
    }
  }

  Future<String?> delete(String saleId) async {
    try {
      await _firebaseFirestore.collection('sales').doc(saleId).delete();
      return null;
    } catch (e) {
      print("Erro ao deletar: $e");
      return "Erro ao deletar: $e";
    }
  }

  Future<String?> changeStatus(
      {required String saleId, required bool status}) async {
    try {
      await _firebaseFirestore
          .collection('sales')
          .doc(saleId)
          .update({'status': !status});
      return null;
    } catch (e) {
      return "Erro ao alterar status: $e";
    }
  }
}
