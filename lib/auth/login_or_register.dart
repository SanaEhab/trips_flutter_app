import 'package:flutter/material.dart';
import 'package:trips_flutter_app/auth/login/loginScreen.dart';
import 'package:trips_flutter_app/auth/register/registerScreen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});
  static const String id = 'loginOrRegister_screen';

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showLoginPage = true;

  void toggelPages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginScreen(onTap: toggelPages);
    }else{
      return RegisterScreen(onTap: toggelPages);
    }
  }
}
