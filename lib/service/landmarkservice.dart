import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/landmark.dart';

class LandmarkService {
  Future<List<Landmark>> loadLandmarks() async {
    final data = await rootBundle.loadString('assets/book_translated.json');
    final List<dynamic> jsonResult = json.decode(data);
    return jsonResult.map((json) => Landmark.fromJson(json)).toList();
  }
}

