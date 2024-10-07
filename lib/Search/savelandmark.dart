import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduation_project/Search/models/landmark.dart';
import 'package:graduation_project/Search/screens/landmark_Detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedLandmarksPage extends StatefulWidget {
  static List<Landmark> savedLandmarks = [];

  static Future<void> addLandmark(Landmark landmark) async {
    savedLandmarks.add(landmark);
    await saveLandmarks();
  }

  static Future<void> removeLandmark(Landmark landmark) async {
    savedLandmarks.remove(landmark);
    await saveLandmarks();
  }

  static bool isLandmarkSaved(Landmark landmark) {
    return savedLandmarks.contains(landmark);
  }

  static Future<void> saveLandmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> landmarks = savedLandmarks.map((landmark) => jsonEncode(landmark.toJson())).toList();
    await prefs.setStringList('savedLandmarks', landmarks);
  }

  static Future<void> loadLandmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? landmarks = prefs.getStringList('savedLandmarks');
    if (landmarks != null) {
      savedLandmarks = landmarks.map((landmark) => Landmark.fromJson(jsonDecode(landmark))).toList();
    }
  }

  @override
  _SavedLandmarksPageState createState() => _SavedLandmarksPageState();
}

class _SavedLandmarksPageState extends State<SavedLandmarksPage> {
  @override
  void initState() {
    super.initState();
    _loadSavedLandmarks();
  }

  Future<void> _loadSavedLandmarks() async {
    await SavedLandmarksPage.loadLandmarks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الاماكن المفضلة'),
          centerTitle: true,
          backgroundColor: Color(0xFFD79977),
        ),
        body: ListView.builder(
          itemCount: SavedLandmarksPage.savedLandmarks.length,
          itemBuilder: (context, index) {
            final landmark = SavedLandmarksPage.savedLandmarks[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.network(landmark.imageUrl, width: 100, fit: BoxFit.cover),
                title: Text(landmark.name),
                subtitle: Text(landmark.governorate),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      SavedLandmarksPage.removeLandmark(landmark);
                    });
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LandmarkDetailPage(landmark: landmark),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
