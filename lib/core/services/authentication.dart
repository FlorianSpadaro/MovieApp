import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  User currentUser;
  User getCurrentUser() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) => this.currentUser = user);
    return currentUser;
  }

  Future registration(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
    return 'Error';
  }

  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
    return 'Error';
  }

  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
