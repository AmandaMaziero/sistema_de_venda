// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String?> delete(String userId) async {
    try {
      await _firebaseFirestore.collection('users').doc(userId).delete();
      return null;
    } catch (e) {
      print("Erro ao deletar: $e");
      return "Erro ao deletar: $e";
    }
  }

  Future<String?> update(
      {required String userId,
      required String email,
      required String name,
      required String type}) async {
    try {
      User? user = _auth.currentUser;
      await user?.updateEmail(email);

      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .update({'name': name, 'email': email, 'type': type});
      return null;
    } catch (e) {
      return "Erro ao editar: $e";
    }
  }

  Future<String?> changeStatus(
      {required String userId, required bool status}) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .update({'status': !status});
      return null;
    } catch (e) {
      return "Erro ao alterar status: $e";
    }
  }
}
