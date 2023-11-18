// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<String?> delete(String userId) async {
    try {
      await _firebaseFirestore.collection('users').doc(userId).delete();
      return null;
    } catch (e) {
      print("Erro ao deletar: $e");
      return "Erro ao deletar: $e";
    }
  }
}
