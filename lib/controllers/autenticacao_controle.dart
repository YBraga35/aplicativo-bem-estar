import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AutenticacaoControle {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Logger logger = Logger();

  // Método para login com e-mail e senha
  Future<String?> loginUsuarios({
    required String email,
    required String senha,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      logger.i("Login efetuado com sucesso!");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Método para login com Google
  Future<User?> loginComGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential usuarioCredential = await _firebaseAuth.signInWithCredential(credential);
      logger.i("Login efetuado com sucesso com Google!");
      return usuarioCredential.user;
    } catch (e) {
      logger.e("Erro ao fazer login com Google: $e");
      return null;
    }
  }
}