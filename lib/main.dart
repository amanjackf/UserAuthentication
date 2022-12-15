import 'package:flutter/material.dart';
import 'package:loginscreen/auth/main_page.dart';
import 'package:loginscreen/pages/signup_page.dart';
import 'package:loginscreen/pages/signup_page.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
