import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation_project/provider/tripprovider.dart';
import 'package:graduation_project/service/landmarkservice.dart';
import 'package:graduation_project/src/screens/Welcome%20Screen.dart';
import 'package:provider/provider.dart'; // تأكد من استيراد Provider
import 'bottom_navigation_bar/bottom_navigator.dart';
import 'const/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final landmarks = await LandmarkService().loadLandmarks();
  runApp(
    ChangeNotifierProvider(
      create: (context) => TripProvider()..loadLandmarks(landmarks),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'), // Arabic
        ],
        theme: ThemeData(
          fontFamily: 'Com',
          appBarTheme: Constants.lightTheme.appBarTheme,
          backgroundColor: Constants.lightTheme.backgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        darkTheme: Constants.darkTheme,
        home:// WelcomeScreen(),
        MyHomePage(),

      ),
    ),
  );
}
