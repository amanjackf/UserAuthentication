import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:lottie/lottie.dart';

import 'forget_pw_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignupPage;
  const LoginPage({Key? key, required this.showSignupPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //to catch the errors during login in and for smooth login

  Future signIn() async {
    try {
      //loading circle
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              e.message.toString(),
            ),
          );
        },
      );
    }
    //to remove the loading state when signed in
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Lottie.network(
                    'https://assets5.lottiefiles.com/private_files/lf30_TBKozE.json',
                    height: 200,
                    width: 500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Hello Again !',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome back, you\'ve  missed!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 95, 95, 95),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Your Email ID:'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Your Password:'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ForgetPasswordPage();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'Forget Password',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a Member?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showSignupPage,
                      child: const Text(
                        '  Register Now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
