import 'package:flutter/cupertino.dart';

class LoginState {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;
  LoginState() {
    ///Initialize variables
  }
}
