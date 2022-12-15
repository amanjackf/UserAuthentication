import 'package:flutter/material.dart';
import 'package:loginscreen/pages/login_page.dart';
import 'package:loginscreen/pages/signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //for initially showing login page
  bool showLoginPage = true;
  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        showSignupPage: toggleScreens,
      );
    } else {
      return SignupPage(
        showLoginPage: toggleScreens,
      );
    }
  }
}
