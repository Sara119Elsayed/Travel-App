import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/tripprovider.dart';
import '../ui/triprecommendation.dart';

class TripPlanner extends StatefulWidget {
  @override
  _TripPlannerState createState() => _TripPlannerState();
}

class _TripPlannerState extends State<TripPlanner> {
  final TextEditingController _budgetController = TextEditingController();
  String _selectedGovernorateFrom = 'القاهرة';
  String _selectedGovernorateTo = 'القاهرة';
  final List<String> _governorates = [
    'القاهرة',
    'الجيزة',
    'الفيوم',
    'البحر الاحمر',
    'جنوب سيناء',
    'مطروح',
    'الاقصر',
    'اسوان',
    'الإسكندرية',
    'الوادي الجديد'
  ];
  final List<String> _governoratesfrom = [
    'القاهرة',
    'الجيزة',
    'الفيوم',
    'الاقصر',
    'اسوان',
    'الاسكندرية',
    'دمياط',
    'المنصورة',
    'الاسماعيلية',
    'بورسعيد'
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'مخطط الرحلات',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor:Color(0xFFD79977),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // Ensure RTL directionality
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
          child: Column(
            children: [
              TextField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'أدخل ميزانيتك',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Color(0xFFD79977),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      'السفر من',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    DropdownButton<String>(
                      value: _selectedGovernorateFrom,
                      onChanged: (value) {
                        setState(() {
                          _selectedGovernorateFrom = value!;
                        });
                      },
                      items: _governoratesfrom.map((governorateFrom) {
                        return DropdownMenuItem(
                          value: governorateFrom,
                          child: Text(governorateFrom),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      'السفر إلى',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    DropdownButton<String>(
                      value: _selectedGovernorateTo,
                      onChanged: (value) {
                        setState(() {
                          _selectedGovernorateTo = value!;
                        });
                      },
                      items: _governorates.map((governorateTo) {
                        return DropdownMenuItem(
                          value: governorateTo,
                          child: Text(governorateTo),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                onPressed: () {
                  Provider.of<TripProvider>(context, listen: false).filterTrips(
                    double.parse(_budgetController.text),
                    _selectedGovernorateFrom,
                    _selectedGovernorateTo,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD79977),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.05,
                  ),
                ),
                child: Text('اعثر على الرحلات'),
              ),
              SizedBox(height: screenHeight * 0.02),
              Expanded(
                child: TripRecommendations(
                  selectedGovernorateFrom: _selectedGovernorateFrom,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
