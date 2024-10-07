import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpingPage extends StatelessWidget {
  const HelpingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD79977),
        title:  Text(
          'مساعدة',
          style: TextStyle(
            color: Colors.white,

            fontSize: 20.0,
          ),

        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15.0,
            ), Text(
              'كيف يمكننا مساعدتك؟',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30.0),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Text(
                'إذا كان لديك أي أسئلة أو استفسارات، يرجى الاتصال بنا عبر البريد الإلكتروني أو الهاتف.',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 40.0),
            ListTile(
              iconColor:  Color(0xFFD79977),
              leading: const Icon(Icons.mail),
              title: const Text('البريد الإلكتروني'),
              subtitle: const Text('mytravel031@gmail.com'),
              onTap: () {
                sendEmail('mytravel031@gmail.com');
              },
            ),
            ListTile(
              iconColor:  Color(0xFFD79977),
              leading: const Icon(Icons.phone),
              title: const Text('رقم الهاتف'),
              subtitle: const Text('+1234567890'),
              onTap: () {
                makePhoneCall('+1234567890');
              },
            ),
          ],
        ),
      ),
    );
  }

  void sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Hello',
        'body': 'Hey there, how are you?',
      },
    );

    final emailUrl = emailUri.toString();
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not launch email';
    }
  }

  void makePhoneCall(String phoneNumber) async {
    final phoneUrl = 'tel:$phoneNumber';
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not launch phone app';
    }
  }
}