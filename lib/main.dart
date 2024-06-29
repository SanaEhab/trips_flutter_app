import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trips_flutter_app/auth/login_or_register.dart';
import 'package:trips_flutter_app/screens/home/home.dart';
import 'package:trips_flutter_app/auth/login/loginScreen.dart';
import 'package:trips_flutter_app/auth/register/registerScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAik3UKpsoVbkWFef1ZVa3_wpfBR_4cwNs',
          appId: '1:496756762670:android:e498a09ee1ae61ff2917bf',
          messagingSenderId: 'com.sana.trips_flutter_app',
          projectId: 'trips-flutter-app-e6ac8')
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginOrRegister.id,
      routes: {
        Home.id:(context) => Home(),
        LoginOrRegister.id:(context)=> const LoginOrRegister(),
        LoginScreen.id: (context) => LoginScreen(onTap: (){}),
        RegisterScreen.id:(context) => RegisterScreen(onTap: (){})
      },
    );
  }
}
