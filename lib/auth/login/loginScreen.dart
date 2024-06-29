import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:trips_flutter_app/constants/buttons.dart';
import '../../constants/constant.dart';
import 'package:trips_flutter_app/screens/home/home.dart';

class LoginScreen extends StatefulWidget {

  final Function()? onTap;
  static const String id = 'login_screen';


  const LoginScreen({required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  void displayError(String message){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(message),
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Flexible(
                    child: SizedBox(
                      child: Row(
                        children: [
                          Icon(Icons.login,
                              size: 100,
                              color: Colors.black54),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text('Log In',
                            style: TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.black54,
                            ),),
                        ],
                      ),

                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your Email'
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password'
                    ),
                  ),

                  const SizedBox(
                    height: 40.0,
                  ),
                  RoundedButton(
                    colour: Colors.black26,
                    title: 'Log In',
                    onPressed: ()async{
                      setState(() {
                        showSpinner = true;
                      });
                      try{
                        final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if(user != null){
                          Navigator.pushNamed(context, Home.id);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      }on FirebaseAuthException catch(e){
                        displayError(e.code);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member!',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text('Register now',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700
                            )),
                      )
                    ],
                  )
                ],
              ),
            ))
    );
  }
}
