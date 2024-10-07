import 'dart:async';

import 'package:flutter/material.dart';
import 'Screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState(){
    super.initState();
    Timer(
        Duration(seconds: 4),
            ()=>Navigator.of(context).push(
          MaterialPageRoute(builder: (c) {
            return onboardingScreen();
          }),
        )
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome_images/p1.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
