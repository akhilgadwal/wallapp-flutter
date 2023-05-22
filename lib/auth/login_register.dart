import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wallapp/pages/login.dart';
import 'package:wallapp/pages/register.dart';

class LoginOrReister extends StatefulWidget {
  const LoginOrReister({super.key});

  @override
  State<LoginOrReister> createState() => _LoginOrReisterState();
}

class _LoginOrReisterState extends State<LoginOrReister> {
  //inti for loginpage or register
  bool showloginreister = true;
  //toggle screen page
  void toggleScreen() {
    setState(() {
      showloginreister = !showloginreister;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginreister) {
      return LoginPage(onTap: toggleScreen);
    } else {
      return RegisterPage(onTap: toggleScreen);
    }
  }
}
