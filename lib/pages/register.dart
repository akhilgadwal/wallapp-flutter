import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/textfiled.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final bool obsureText = true;

  void signUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    if (context.mounted) {
      Navigator.of(context).pop();
    }
    if (passController.text != confirmController.text) {
      Navigator.of(context).pop();
      displayMessage('Password dont match');
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      //after creating new user create new doc init
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'username': emailController.text.split('@')[0],
        'bio': "Empty  bio"
      });
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
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
          padding: const EdgeInsets.all(25.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            const SizedBox(
              height: 10,
            ),
            //password text field
            MyTextField(
                obsureText: obsureText,
                controller: confirmController,
                hintText: 'Confirm Password'),
            //login or registe button
            MyButton(
              text: 'Sign-Up',
              onTap: signUp,
            ),
            Row(
              children: [
                Text(
                  'Already Member',
                  style: TextStyle(color: Colors.grey.shade50),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Login here',
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
