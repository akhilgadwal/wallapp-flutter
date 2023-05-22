import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallapp/components/textfiled.dart';

import '../components/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});
  final Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final bool obsureText = true;

  void signIn() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            //icons
            const Icon(
              Icons.lock,
              size: 30,
            ),
            //welcometext
            const Text(
              'Welcome Back You have been Missed',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            //textfield
            MyTextField(
                obsureText: false,
                controller: emailController,
                hintText: 'Enter Email'),
            const SizedBox(
              height: 10,
            ),
            //password text field
            MyTextField(
                obsureText: obsureText,
                controller: passController,
                hintText: 'Enter Password'),
            //login or registe button
            MyButton(
              text: 'Sign-In',
              onTap: signIn,
            ),
            Row(
              children: [
                Text(
                  'Not a member ? ',
                  style: TextStyle(color: Colors.grey.shade50),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Register Now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
