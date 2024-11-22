import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticateController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger logger = Logger();

  // Método para login com e-mail e senha
  Future<String?> loginUsers({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.i("Login efetuado com sucesso!");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Método para registro de novos usuários
  Future<String?> signUpUsers({
    required String nome,
    required String email,
    required String senha,
    required String telefone,
    required String pronomes,
    required int idade,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      logger.i("Cadastro efetuado com sucesso!");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Método para login com Google
  Future<User?> loginComGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential usuarioCredential =
          await _firebaseAuth.signInWithCredential(credential);
      logger.i("Login efetuado com sucesso com Google!");
      return usuarioCredential.user;
    } catch (e) {
      logger.e("Erro ao fazer login com Google: $e");
      return null;
    }
  }

  // Método para excluir conta e dados do usuário
  Future<void> excluirConta(BuildContext context) async {
    try {
      User? usuarioAtual = _firebaseAuth.currentUser;

      if (usuarioAtual != null) {
        // Referência ao documento do usuário no Firestore
        DocumentReference userDocRef =
            _firestore.collection('users').doc(usuarioAtual.uid);

        // Exclui o documento do usuário no Firestore
        await userDocRef.delete();

        // Exclui todos os dados associados ao usuário (exemplo: hábitos)
        QuerySnapshot dadosUsuario = await _firestore
            .collection('habits')
            .where('userId', isEqualTo: usuarioAtual.uid)
            .get();

        for (var doc in dadosUsuario.docs) {
          await doc.reference.delete();
        }

        // Exclui a conta de autenticação do usuário
        await usuarioAtual.delete();

        // Mensagem de confirmação para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Conta e dados excluídos com sucesso.')),
        );
        logger.i("Conta e dados excluídos com sucesso!");
      }
    } catch (e) {
      // Erro durante a exclusão da conta
      logger.e("Erro ao excluir conta: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao excluir a conta. Tente novamente.')),
      );
    }
  }
}