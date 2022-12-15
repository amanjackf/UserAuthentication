import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginscreen/auth/main_page.dart';
import 'package:lottie/lottie.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Passowrd reset Link sent! Check your mail..'),
          );
        },
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: Lottie.network(
                    'https://assets9.lottiefiles.com/packages/lf20_IUWMcw.json',
                    height: 200,
                    width: 400,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Reset Your Password',
                style: GoogleFonts.bebasNeue(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 15),
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
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Your Email ID:'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: passwordReset,
                child: const Text(
                  'Send Reset Link',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MainPage();
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Login ',
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
            ],
          ),
        ),
      ),
    );
  }
}
