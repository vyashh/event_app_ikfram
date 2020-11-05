import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBProvider {
  final FirebaseAuth _firebaseAuth;
  UserCredential userCredential;

  DBProvider(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> submitForm(String email, String password, bool isLogin) async {
    if (isLogin) {
      try {
        userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } on FirebaseAuthException catch (error) {
        return error.message;
      }
    } else {
      try {
        userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
      } on FirebaseAuthException catch (error) {
        return error.message;
      }
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user.uid)
        .set({
      'email': email,
      // 'email': email,
    });
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }
}
