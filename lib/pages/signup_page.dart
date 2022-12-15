import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignupPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

//text controllers
class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

//disposing
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }
//signup method

  Future signUp() async {
    
    try {
      if (passwordConfirmed()) {
        //create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
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

    addUserDetails(
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
      _emailController.text.trim(),
      int.parse(
        _ageController.text.trim(),
      ),
    );
  }

  //add user details

  Future addUserDetails(
      String firstName, String lastName, String email, int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'age': age,
      'email': email,
    });
  }

  //password confirmed method
  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
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
                    'https://assets2.lottiefiles.com/packages/lf20_CgL682.json',
                    width: 500,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Lets get you started',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Create a New Account for you',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 95, 95, 95),
                  ),
                ),
                const SizedBox(height: 10),

                //first name text field

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
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'First name:'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                //last name textfield
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
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Last Name:'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //age textfield
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
                        controller: _ageController,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Age'),
                      ),
                    ),
                  ),
                ),

                //email id textfield

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
                        controller: _emailController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Your Email ID:'),
                      ),
                    ),
                  ),
                ),

                //password textfield

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

                //confirm password textfield

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
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'confirm Your Password:'),
                      ),
                    ),
                  ),
                ),

                //signup textfield

                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign Up',
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

                //already a member textfield

                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already a Member?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //login text field

                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        '  Login Now',
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
