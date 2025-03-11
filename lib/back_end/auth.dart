import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthSetup {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create Account =============================================================
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }
  }

  //Login Account =============================================================
  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    }catch (e){
      if(e is FirebaseAuthException) {
        log("Firebase Error: ${e.message}");
      } else {
        log("Unknown Error: $e");
      }
      return null;
    }
  }
}
