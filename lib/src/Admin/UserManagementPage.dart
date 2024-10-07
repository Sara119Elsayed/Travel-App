import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  late Stream<QuerySnapshot> _usersStream;

  @override
  void initState() {
    super.initState();
    _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD79977),// تعيين لون خلفية الشريط
        title: Text(
          'إدارة المستخدمين',
          style: TextStyle(
            color: Colors.white, // تعيين لون النص
          ),
        ),
        leading: IconButton( // زر العودة
          icon: Icon(Icons.arrow_back, color: Colors.white), // تعيين لون الأيقونة
          onPressed: () {
            // تنفيذ العملية المطلوبة عند الضغط على زر العودة إلى صفحة الإدارة الرئيسية
            Navigator.of(context).pop();
          },
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('حدث خطأ: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('لا يوجد مستخدمين.'),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['sender']),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // افتح صفحة تحرير المستخدم
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUserPage(userData: data),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class EditUserPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditUserPage({Key? key, required this.userData}) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData['name']);
    _emailController = TextEditingController(text: widget.userData['sender']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD79977),
        title: Text('تحرير المستخدم'),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'الاسم'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // قم بتحديث بيانات المستخدم في Firestore
                FirebaseFirestore.instance.collection('users').doc(widget.userData['uid']).update({
                  'name': _nameController.text,
                  'sender': _emailController.text,
                }).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('تم تحديث بيانات المستخدم بنجاح.'),
                  ));
                  Navigator.pop(context); // اغلق صفحة تحرير المستخدم بعد التحديث
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('حدث خطأ أثناء تحديث بيانات المستخدم: $error'),
                    backgroundColor: Colors.red,
                  ));
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD79977)),
              ),
              child: Text('حفظ التغييرات'),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
