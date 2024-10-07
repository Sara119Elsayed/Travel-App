import 'package:flutter/material.dart';
import 'package:graduation_project/src/Admin/UserManagementPage.dart';

import 'NotificationManagementPage.dart';// استيراد صفحة إدارة المستخدمين

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة المسؤولين'),
        backgroundColor: Color(0xFFD79977),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('إدارة المستخدمين'),
            onTap: () {
              // عند الضغط على إدارة المستخدمين، قم بالانتقال إلى صفحة إدارة المستخدمين
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserManagementPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('إدارة الاشعارات'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationManagementPage()));
              // افتح شاشة إدارة المقالات
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('الإعدادات'),
            onTap: () {
              // افتح شاشة الإعدادات
            },
          ),
          // يمكنك إضافة المزيد من العناصر هنا
        ],
      ),
    );
  }
}
