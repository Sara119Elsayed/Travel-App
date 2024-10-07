import 'package:flutter/material.dart';
import '../models/landmark.dart';
import 'package:flutter/foundation.dart';
class TripProvider with ChangeNotifier {
  List<Landmark> _landmarks = [];
  List<Landmark> _recommendedTrips = [];

  List<Landmark> get recommendedTrips => _recommendedTrips;

  void loadLandmarks(List<Landmark> landmarks) {
    _landmarks = landmarks;
    notifyListeners();
  }

  void filterTrips(double budget, String travelFrom, String governorateTo) {
    _recommendedTrips = _landmarks.where((landmark) {
      final price = landmark.prices[travelFrom] ?? double.infinity;
      return price <= budget && landmark.governorate == governorateTo;
    }).toList();
    notifyListeners();
  }
}
