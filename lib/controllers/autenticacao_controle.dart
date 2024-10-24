import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AutenticacaoControle {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Uso de uma lib para poder fazer logs  
  final Logger logger = Logger();

  Future<String?> loginUsuarios(
      {required String email, required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
          logger.i("Login efetuado com sucesso!");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
