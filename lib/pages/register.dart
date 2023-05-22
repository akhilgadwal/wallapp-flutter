import 'package:firebase_auth/firebase_auth.dart';
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
      Navigator.pop(context);
    }
    if (passController.text != confirmController.text) {
      Navigator.pop(context);
      displayMessage('Password dont match');
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passController.text);
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
            const SizedBox(
              height: 10,
            ),
            //password text field
            MyTextField(
                obsureText: obsureText,
                controller: passController,
                hintText: 'Confirm Password'),
            //login or registe button
            MyButton(
              text: 'Sign-Up',
              onTap: () {},
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
