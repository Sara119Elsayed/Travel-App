import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/src/screens/signup_screen.dart';
import '../../bottom_navigation_bar/bottom_navigator.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context , snapshot){
          if (snapshot.hasData){
            return  MyHomePage();
          }else{
            return SignUpScreen();
          }
        }

        ),
      ),
    );
  }
}