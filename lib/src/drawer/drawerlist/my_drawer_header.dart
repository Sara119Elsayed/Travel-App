import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  final user = FirebaseAuth.instance.currentUser!;
  String? userName;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    // استعلام Firestore لجلب اسم المستخدم وعنوان URL لصورة الملف الشخصي
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          userName = documentSnapshot.get('name');
          profileImageUrl = documentSnapshot.get('profileImageUrl');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFD79977),
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                // استخدام NetworkImage لتحميل الصورة من Firebase Storage
                image: profileImageUrl != null
                    ? NetworkImage(profileImageUrl!)
                    : AssetImage('assets/images/profile.jpg') as ImageProvider<Object>,
              ),
            ),
          ),
          Text(
            userName ?? "جاري التحميل...", // عرض "جاري التحميل..." قبل تحميل اسم المستخدم
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            user.email!,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
