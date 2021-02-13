import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_todo/constants.dart';
import 'package:my_todo/pages/auth_page.dart';
import 'package:my_todo/pages/home_page.dart';

class FirebaseAuthHelper extends ChangeNotifier {
  bool _signInLoading = false;
  bool _signUpLoading = false;

  bool get siginInLoading => _signInLoading;
  bool get signUpLoading => _signUpLoading;

  final _firebaseAuth = FirebaseAuth.instance;
  Stream<User> isLoggedIn() {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    _signInLoading = true;
    notifyListeners();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      _signInLoading = false;
      notifyListeners();
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Constants.showErrorSnackBar(
            context: context, content: 'No user found for that email.');
        _signInLoading = false;
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        Constants.showErrorSnackBar(
            context: context,
            content: 'Wrong password provided for that user.');
        _signInLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _signInLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    _signUpLoading = true;
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      _signUpLoading = false;
      notifyListeners();
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Constants.showErrorSnackBar(
            context: context, content: 'The password provided is too weak.');
        _signUpLoading = false;
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        Constants.showErrorSnackBar(
            context: context,
            content: 'The account already exists for that email.');
        _signUpLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _signUpLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    Navigator.of(context).pushReplacementNamed(AuthPage.routeName);
    notifyListeners();
  }
}
