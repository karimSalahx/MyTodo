import 'package:flutter/material.dart';
import 'package:my_todo/constants.dart';
import 'package:my_todo/services/firebase_auth_helper.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  static const routeName = 'signIn-page';
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuthHelper _authProvider;
  bool _signInLoading;
  bool _signUpLoading;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = Provider.of<FirebaseAuthHelper>(context);
    _signInLoading = _authProvider.siginInLoading;
    _signUpLoading = _authProvider.signUpLoading;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'MyTodo',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintStyle: TextStyle(letterSpacing: 1.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (text) {
                    bool emailValid = RegExp(
                      Constants.emailRegex,
                    ).hasMatch(text);
                    if (!emailValid) return 'Email is Not valid';
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(letterSpacing: 1.3),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      prefixIcon: Icon(Icons.lock)),
                  controller: _passwordController,
                  obscureText: true,
                  validator: (text) {
                    if (text.length < 6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
              ),
              Consumer<FirebaseAuthHelper>(
                builder: (_, __, ___) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _signInLoading
                        ? CircularProgressIndicator()
                        : FlatButton(
                            focusColor: Colors.blueAccent,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _authProvider.signInWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text,
                                    context);
                              }
                            },
                          ),
                    _signUpLoading
                        ? CircularProgressIndicator()
                        : FlatButton(
                            focusColor: Colors.blueAccent,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _authProvider.signUpWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text,
                                    context);
                              }
                            },
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
