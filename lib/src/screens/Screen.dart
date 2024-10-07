import 'package:flutter/material.dart';
import 'package:graduation_project/src/screens/Second%20Screen.dart';
import 'package:graduation_project/src/screens/third%20screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'FirstScreen.dart';
class onboardingScreen extends StatefulWidget{
  @override
  _onboardingScreenState createState() => _onboardingScreenState();
}

class _onboardingScreenState extends State<onboardingScreen> {
  PageController _controller=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body:Stack(
    children:[
     PageView(
       controller: _controller,
      children: [
       FirstScreen(),
       SecondScreen(),
       ThirdScreen(),


  ],
     ),
      Container(
        alignment: Alignment(0,0.90),
          child: SmoothPageIndicator(controller: _controller, count: 3,
            effect: WormEffect(
              dotColor: Colors.white, // Change the color here
              activeDotColor: Color(0xFFD79977), // Change the color of the active dot
            ),))
    ])
    );
  }
}