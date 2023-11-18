import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String?> register({
    required String email,
    required String password,
    required String name,
    required String cpf,
    required DateTime birthDate,
    required String type,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Atualiza o nome de exibição do usuário
      await userCredential.user!.updateDisplayName(name);

      // Cria um mapa com as informações adicionais do usuário
      Map<String, dynamic> userInfo = {
        'uid': userCredential.user!.uid,
        'name': name,
        'email': email,
        'cpf': cpf,
        'birthDate': birthDate,
        'type': type,
        'status': true
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userInfo);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "Email já cadastrado";
      }
      return "Erro ao cadastrar: ${e.message}";
    } catch (e) {
      return "Erro ao cadastrar: $e";
    }
  }

  Future<String?> login(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Usuário não encontrado";
      } else if (e.code == 'wrong-password') {
        return "Senha incorreta";
      }
    } catch (e) {
      return "Erro ao entrar";
    }
    return null;
  }
}
