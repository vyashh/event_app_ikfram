import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth;

  AuthProvider(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Inloggen');
      return "Signed in";
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('Registreer');
      return "Signed in";
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }

  Future<String> submitForm(String email, String password, bool isLogin) async {
    if (isLogin) {
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        return "Signed in";
      } on FirebaseAuthException catch (error) {
        return error.message;
      }
    } else {
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        print('Registreer');
        return "Signed in";
      } on FirebaseAuthException catch (error) {
        return error.message;
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }
}
