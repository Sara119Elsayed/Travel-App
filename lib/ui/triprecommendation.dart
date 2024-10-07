import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/tripprovider.dart';

class TripRecommendations extends StatelessWidget {
  final String selectedGovernorateFrom;

  TripRecommendations({required this.selectedGovernorateFrom});
  String convertToArabicNumerals(int? number) {
    const englishToArabicDigits = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩'
    };

    // Provide a default value of 0 if the number is null
    final numStr = (number ?? 0).toString();
    return numStr.split('').map((digit) => englishToArabicDigits[digit] ?? digit).join();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) {
        final trips = tripProvider.recommendedTrips;
        return Directionality(
          textDirection: TextDirection.rtl, // Ensure RTL directionality
          child: ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              final price = trip.prices[selectedGovernorateFrom];
              return Card(
                color: Colors.white70,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        trip.imageUrl,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            trip.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD79977),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'التكلفة: ${convertToArabicNumerals(price)} جنيه مصري',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'الوجهة: ${trip.governorate}',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );


            },
          ),
        );
      },
    );
  }
}