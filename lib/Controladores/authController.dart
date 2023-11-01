import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error al iniciar sesión: $e');
      return null;
    }
  }
}

