import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Search/screens/landmark_search.dart';
import 'package:graduation_project/src/drawer/drawerlist/profile.dart';
import 'package:graduation_project/src/drawer/maindrawer.dart';
import 'package:graduation_project/src/map/file1.dart';
import 'package:graduation_project/src/icon%20pages/HeritageSite.dart';
import 'package:graduation_project/src/icon%20pages/SearchPage.dart';
import 'package:graduation_project/weather_lib/view/SearchPage.dart';



// Define a color for the bottom navigation bar
Color buttonColor = Color(0xFFD79977);

// Define a simple SizeConfig class to provide screen size configurations
class SizeConfig {
  static double? screenHeight;
  static double? screenWidth;
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screen = [
    Maindrawer(),
    LandmarkSearchPage(),
    HeritageSitePage(),
    SearchPageweather(),
    ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    final items = [
      Icon(Icons.home, size: 30.0),
      Icon(Icons.search, size: 30.0),
      Icon(Icons.camera_alt, size: 30.0),
      Icon(Icons.wb_sunny, size: 30.0),
      Icon(Icons.person, size: 30.0),

     // Adjust the icon size as needed

    ];

    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          body: screen[index],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(color: Colors.white),
            ),
            child: CurvedNavigationBar(
              key: navigationKey,
              color:Colors.black54,
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: buttonColor,
              height:
              60.0, // Adjust the height of the bottom navigation bar as needed
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 400),
              index: index,
              items: items,
              onTap: (index) => setState(() => this.index = index),
            ),
          ),
        ),
      ),
    );
  }
}

var registerColor = Color(0xFFffdfb4);
var lightColor = Color(0xFFFFC971);
var texthint = Color(0xFF666666);
