import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_todo/pages/auth_page.dart';
import 'package:my_todo/pages/home_page.dart';
import 'package:my_todo/pages/sign_in_page.dart';
import 'package:my_todo/services/database_service_provider.dart';
import 'package:my_todo/services/firebase_auth_helper.dart';
import 'package:my_todo/services/priority_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthHelper>(
          create: (_) => FirebaseAuthHelper(),
        ),
        ChangeNotifierProvider<PriorityService>(
          create: (_) => PriorityService(),
        ),
        ChangeNotifierProvider<DatabaseServiceProvider>(
          create: (_) => DatabaseServiceProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthPage(),
        routes: {
          AuthPage.routeName: (_) => AuthPage(),
          SignInPage.routeName: (_) => SignInPage(),
          HomePage.routeName: (_) => HomePage(),
        },
      ),
    );
  }
}
