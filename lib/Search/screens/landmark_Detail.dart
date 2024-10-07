import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/Search/savelandmark.dart';
import '../models/landmark.dart';

class LandmarkDetailPage extends StatefulWidget {
  final Landmark landmark;

  LandmarkDetailPage({required this.landmark});

  @override
  _LandmarkDetailPageState createState() => _LandmarkDetailPageState();
}

class _LandmarkDetailPageState extends State<LandmarkDetailPage> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    isSaved = SavedLandmarksPage.isLandmarkSaved(widget.landmark);
  }

  void toggleSaveLandmark() async {
    setState(() {
      if (isSaved) {
        SavedLandmarksPage.removeLandmark(widget.landmark);
      } else {
        SavedLandmarksPage.addLandmark(widget.landmark);
      }
      isSaved = !isSaved;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isSaved ? 'Landmark saved!' : 'Landmark removed!'),
      ),
    );

    // Save changes to persistent storage
    await SavedLandmarksPage.saveLandmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set text direction to RTL
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.landmark.name, ),
          centerTitle: true,
          backgroundColor: Color(0xFFD79977),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0), // Same radius as the Container
                      child: Image.network(
                        widget.landmark.imageUrl,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


                  Positioned(
                    top: 10,
                    left: 10,
                    // top: 10,
                    // right: 10,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(100),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          height: 30,
                          width: 30,
                          child: IconButton(
                            icon: Icon(
                              isSaved ? Icons.favorite : Icons.favorite_border,
                             color: Color(0xFFD79977),
                              size: 16,
                            ),
                            onPressed: toggleSaveLandmark,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(100),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                          color: Color(0xFFD79977),
                            shape: BoxShape.circle,
                          ),
                          height: 30,
                          width: 30,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.landmark.name,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD79977),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                         color: Color(0xFFD79977),
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.landmark.governorate,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFD79977),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'التقييم',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                       color: Color(0xFFD79977),
                      ),
                    ),
                    SizedBox(height: 10),
                    RatingBar.builder(
                      initialRating: widget.landmark.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Color(0xFFD79977),
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          widget.landmark.rating = rating;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'الوصف',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFFD79977),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.landmark.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

