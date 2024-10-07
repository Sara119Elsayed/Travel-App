import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // استيراد Firebase Firestore
import '../home.dart'; // استيراد صفحة الصفحة الرئيسية

class RateAppPage extends StatefulWidget {
  @override
  State<RateAppPage> createState() => _RateAppPageState();
}

class _RateAppPageState extends State<RateAppPage> {
  final _firestore = FirebaseFirestore.instance;
  final CollectionReference ratingCollection = FirebaseFirestore.instance.collection('rating_app');
  final user = FirebaseAuth.instance.currentUser!;
  double? userRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD79977), // لون خلفية الـ AppBar
        title: Text(
          'تقييم التطبيق',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // لون نص الـ AppBar
          ),
        ),
        centerTitle: true, // توسيط عنوان الـ AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            Text(
              'نشكرك على استخدام التطبيق! كم تقيم التطبيق؟',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40.0,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {

                setState(() {
                  userRating = rating;
                });

                // يمكنك هنا تنفيذ أي شيء آخر تريده بناءً على التقييم
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                 // تقييم المستخدم، يمكنك استبداله بقيمة المتغير الذي يخزن التقييم
                // إضافة تقييم المستخدم إلى Firestore
                await _firestore.collection('rating_app').add({
                  'sender': user.email!,
                  'stars': userRating,
                  'timestamp': FieldValue.serverTimestamp(),
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'شكراً لتقييم التطبيق!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Color(0xFFD79977),
                  ),
                );
              },
              child: Text('تقييم التطبيق'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD79977),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
