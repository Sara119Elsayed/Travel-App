import 'package:flutter/material.dart';
import 'package:graduation_project/src/drawer/drawerlist/notifications.dart';
import 'package:graduation_project/src/drawer/drawerlist/profile.dart';
import 'package:graduation_project/src/settingspages/Contact.dart';
import 'package:graduation_project/src/settingspages/around_app.dart';
import '../../settingspages/help.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isNotificationsEnabled = false;
  bool isHighQualityImagesEnabled = false;
  bool isEmailNotificationsEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات'),
        backgroundColor: Color(0xFFD79977),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            ListTile(
              leading: Icon(Icons.language, color: Color(0xFFD79977)),
              title: Text('اللغة'),
              onTap: () {
                _showLanguageDialog(context);
                // يمكنك هنا تنفيذ إجراء معين عند النقر على اللغة
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications, color: Color(0xFFD79977)),
              title: Text('الإشعارات'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle, color: Color(0xFFD79977)),
              title: Text('الملف الشخصي'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.security, color: Color(0xFFD79977)),
              title: Text('الأمان والخصوصية'),
              onTap: () {
                _showSecurityPrivacyDialog(context);
                // يمكنك هنا تنفيذ إجراء معين عند النقر على الأمان والخصوصية
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.feedback, color: Color(0xFFD79977)),
              title: Text('مراسلتنا'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Contact()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info, color: Color(0xFFD79977)),
              title: Text('حول التطبيق'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutApp()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help, color: Color(0xFFD79977)),
              title: Text('المساعدة'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpingPage()),
                );
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('اختر اللغة'),
          content: Text('هل تريد تغيير اللغة إلى العربية؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // هنا يمكنك تنفيذ الإجراء الذي تريده عند النقر على "موافق"
                // في هذا المثال، سنقوم بطباعة "اللغة العربية"
                print('اللغة العربية');
                Navigator.of(context).pop(); // لإخفاء الرسالة
              },
              child: Text('موافق'),
            ),
            TextButton(
              onPressed: () {
                // هنا يمكنك تنفيذ الإجراء الذي تريده عند النقر على "إلغاء"
                // في هذا المثال، سنقوم بطباعة "إلغاء"
                print('إلغاء');
                Navigator.of(context).pop(); // لإخفاء الرسالة
              },
              child: Text('إلغاء'),
            ),
          ],
        );
      },
    );
  }

  void _showSecurityPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('الأمان والخصوصية'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text('تفعيل استقبال الإشعارات'),
                        ),
                        Switch(
                          value: isNotificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              isNotificationsEnabled = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text('تحميل الصور بجودة عالية'),
                        ),
                        Switch(
                          value: isHighQualityImagesEnabled,
                          onChanged: (value) {
                            setState(() {
                              isHighQualityImagesEnabled = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text('استقبال تنبيهات عبر البريد الإلكتروني'),
                        ),
                        Switch(
                          value: isEmailNotificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              isEmailNotificationsEnabled = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('حفظ',
                    style: TextStyle(color: Color(0xFFD79977)),),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
