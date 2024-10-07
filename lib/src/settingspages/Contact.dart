import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // دالة لإضافة الرسالة إلى Firestore
  void _sendMessage(String name, String email, String message) {
    // استخدام collection في Firestore
    FirebaseFirestore.instance.collection('Send_message').add({
      'name': name,
      'gmail': email, // تم تعديل الاسم من gmail إلى email
      'the_message': message,
    }).then((value) {
      // يمكنك هنا إضافة أي إجراء بعد إرسال الرسالة مثل عرض رسالة تأكيد
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('تم الإرسال بنجاح'),
            content: Text('تم إرسال الرسالة بنجاح.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق مربع الحوار
                },
                child: Text('موافق'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      // يمكنك هنا عرض رسالة خطأ في حالة حدوث خطأ أثناء الإرسال
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('خطأ في الإرسال'),
            content: Text('حدث خطأ أثناء محاولة إرسال الرسالة.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق مربع الحوار
                },
                child: Text('موافق'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD79977),
        title:  Row(
          children: [
            SizedBox(
              width: 90.0,
            ),
            Text(
              'مراسلتنا',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(

            children: [
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'أرسل لنا رسالة  ',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'اسمك',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'البريد الإلكتروني',
                  suffixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'الرسالة',
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 120.0,
                  vertical: 90.0,
                ),
                child: TextButton(
                  onPressed: () {
                    // عند الضغط على زر الإرسال، يتم استدعاء دالة _sendMessage
                    _sendMessage(
                      _nameController.text,
                      _emailController.text,
                      _messageController.text,
                    );
                  },
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: 50.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFD79977),
                      borderRadius: BorderRadius.circular(10.0), // تحديد الحواف الدائرية
                    ),
                    child: Center(
                      child: const Text(
                        'إرسال',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                ),
              ),
                )],
          ),
        ),
      ),
    );
  }
}
