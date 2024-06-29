import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:trips_flutter_app/screens/home/home.dart';
import 'package:trips_flutter_app/constants/buttons.dart';
import '../../constants/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {

  final Function()? onTap;
  static const String id = 'register_screen';

  const RegisterScreen({required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool showSnipper = false;
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: ModalProgressHUD(
            inAsyncCall: showSnipper,
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
                          Icon(Icons.app_registration,
                              size: 100,
                              color: Colors.black54),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text('Register',
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
                    colour: Colors.black54,
                    title: 'Sign Up',
                    onPressed: () async {
                      setState(() {
                        showSnipper = true;
                      });
                      try{
                        UserCredential newUser = await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password
                        );
                        //create a new doc in the firebase
                        FirebaseFirestore.instance
                        .collection("Users")
                        .doc(newUser.user!.email)
                        .set({
                          'username' : email.split('@')[0]
                        });
                        if(newUser != null){
                          Navigator.pushNamed(context, Home.id);
                        }
                        setState(() {
                          showSnipper = false;
                        });
                      }catch(e){
                        print(e);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account!',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text('Login now',
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
