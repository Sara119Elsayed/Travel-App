import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Add this line for rating bar
import 'package:graduation_project/Search/screens/landmark_Detail.dart';
import '../models/landmark.dart';

class LandmarkSearchPage extends StatefulWidget {
  @override
  _LandmarkSearchPageState createState() => _LandmarkSearchPageState();
}

class _LandmarkSearchPageState extends State<LandmarkSearchPage> {
  List<Landmark> landmarks = [];
  List<Landmark> filteredLandmarks = [];
  String selectedCategory = 'الكل';

  @override
  void initState() {
    super.initState();
    loadLandmarks();
  }

  Future<void> loadLandmarks() async {
    final String response = await rootBundle.loadString('assets/book_translated.json');
    final data = await json.decode(response) as List;
    setState(() {
      landmarks = data.map((json) => Landmark.fromJson(json)).toList();
      filteredLandmarks = landmarks;
    });
  }

  void filterLandmarks(String query) {
    final filtered = landmarks.where((landmark) {
      final nameLower = landmark.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower) && (selectedCategory == 'الكل' || landmark.category == selectedCategory);
    }).toList();

    setState(() {
      filteredLandmarks = filtered;
    });
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      filterLandmarks('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set text direction to RTL
      child: Scaffold(
        appBar: AppBar(
          title: Text('ابحث عن مكان'),
          centerTitle: true,
          backgroundColor: Color(0xFFD79977),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: filterLandmarks,
                decoration: InputDecoration(
                  labelText: 'ادخل اسم المكان',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0), // Set the border radius here
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0), // Set the border radius when focused
                    borderSide: BorderSide(
                      color: Color(0xFFD79977),// Change this to your preferred border color
                      width: 2.0, // Adjust the width of the border
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0), // Set the border radius when enabled
                    borderSide: BorderSide(
                      color: Colors.grey, // Change this to your preferred border color
                      width: 1.0, // Adjust the width of the border
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: Text('الكل'),
                      selected: selectedCategory == 'الكل',
                      onSelected: (selected) {
                        filterByCategory('الكل');
                      },
                    ),
                    SizedBox(width: 8.0),
                    FilterChip(
                      label: Text('الأهرامات'),
                      selected: selectedCategory == 'أهرامات',
                      onSelected: (selected) {
                        filterByCategory('أهرامات');
                      },
                    ),
                    SizedBox(width: 8.0),
                    FilterChip(
                      label: Text('المقابر'),
                      selected: selectedCategory == 'مقابر',
                      onSelected: (selected) {
                        filterByCategory('مقابر');
                      },
                    ),
                    SizedBox(width: 8.0),
                    FilterChip(
                      label: Text('متاحف'),
                      selected: selectedCategory == 'متاحف',
                      onSelected: (selected) {
                        filterByCategory('متاحف');
                      },
                    ),
                    SizedBox(width: 8.0),
                    FilterChip(
                      label: Text('معابد'),
                      selected: selectedCategory == 'معابد',
                      onSelected: (selected) {
                        filterByCategory('معابد');
                      },
                    ),
                    SizedBox(width: 8.0),
                    FilterChip(
                      label: Text('حدائق'),
                      selected: selectedCategory == 'حدائق',
                      onSelected: (selected) {
                        filterByCategory('حدائق');
                      },
                    ),
                    SizedBox(width: 8.0),
                    FilterChip(
                      label: Text('أودية'),
                      selected: selectedCategory == 'أودية',
                      onSelected: (selected) {
                        filterByCategory('أودية');
                      },
                    ),
                    SizedBox(width: 8.0),
                    FilterChip(
                      label: Text('قلاع'),
                      selected: selectedCategory == 'قلاع',
                      onSelected: (selected) {
                        filterByCategory('قلاع');
                      },
                    ),
                    SizedBox(width: 8.0),
                    FilterChip(
                      label: Text('أخرى'),
                      selected: selectedCategory == 'أخرى',
                      onSelected: (selected) {
                        filterByCategory('أخرى');
                      },
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: filteredLandmarks.length,
                itemBuilder: (context, index) {
                  final landmark = filteredLandmarks[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading:ClipRRect(
                        borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                        child: Image.network(
                          landmark.imageUrl,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),

                      title: Text(landmark.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(landmark.governorate),
                          RatingBar.builder(
                            initialRating: landmark.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20.0, // Adjust this value to make the stars smaller
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color:Color(0xFFD79977),
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                landmark.rating = rating;
                              });
                            },
                          ),
                        ],
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
          ],
        ),
      ),
    );
  }
}



