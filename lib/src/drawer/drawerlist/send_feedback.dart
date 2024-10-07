import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuggestionsPage extends StatefulWidget {
  @override
  State<SuggestionsPage> createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  final _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!; //email
  String? messageText; //message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD79977), // Set custom color
        title: Text(
          'ارسال الاقتراحات',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set text color to white
          ),
        ),
        centerTitle: true, // Center align the title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              Text(
                'نحن نرحب بجميع الاقتراحات والملاحظات منك!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    messageText = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'الاقتراح',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFD79977), // Set border color
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFD79977), // Set focused border color
                    ),
                  ),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (messageText != null && messageText!.isNotEmpty) {
                    try {
                      await _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': user.email!,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم إرسال الاقتراح بنجاح'),
                          backgroundColor: Color(0xFFD79977),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      setState(() {
                        messageText = ''; // Clear the input field after sending
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('حدث خطأ أثناء إرسال الاقتراح'),
                          backgroundColor: Color(0xFFD79977),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      print('Error: $e');
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('يرجى إدخال نص الاقتراح'),
                        backgroundColor: Color(0xFFD79977),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Text('إرسال'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD79977),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
