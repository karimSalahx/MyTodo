import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_todo/pages/home_page.dart';
import 'package:my_todo/pages/sign_in_page.dart';
import 'package:my_todo/services/firebase_auth_helper.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  static const routeName = '/auth-page';
  @override
  Widget build(BuildContext context) {
    final firebasAuthProvider = Provider.of<FirebaseAuthHelper>(context);
    return Scaffold(
      body: StreamBuilder<User>(
        stream: firebasAuthProvider.isLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final user = snapshot.data;
          if (user == null)
            return SignInPage();
          else
            return HomePage();
        },
      ),
    );
  }
}
