import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center
        (child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text
              ('لقد قمت بتسجيل الدخول',
               style: TextStyle(fontSize: 22),
           ),
            Text(
              user.email!,
              style: TextStyle(fontSize: 22),
            ),
            MaterialButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                },
              color:  Color(0xFFD79977),
              child: Text('تسجيل الخروج'),
            ),
          ],
        )
      ),
    );
  }
}
