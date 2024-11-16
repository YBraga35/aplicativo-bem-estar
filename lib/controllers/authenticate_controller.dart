import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthenticateController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Uso de uma lib para poder fazer logs  
  final Logger logger = Logger();

  Future<String?> loginUsers(
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

  Future<String?> signUpUsers({
    required String nome,
    required String email,
    required String telefone,
    required String pronomes,
    required int idade,
    required String senha,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // Atualizar o perfil do usuário
      await userCredential.user?.updateDisplayName(nome);
      await userCredential.user?.updatePhotoURL('URL_DA_FOTO_DE_PERFIL'); // Atualize com a URL da foto de perfil

      logger.i("Usuário cadastrado com sucesso!");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}