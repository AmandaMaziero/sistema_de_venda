import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  register({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "Email já cadastrado";
      }
    } catch (e) {
      return "Erro ao cadastrar";
    }
  }

  Future<String?> login(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // return "Usuário não encontrado";
        String result = await register(email: email, password: password);
        return result;
      } else if (e.code == 'wrong-password') {
        return "Senha incorreta";
      }
    } catch (e) {
      return "Erro ao entrar";
    }
    return null;
  }
}
