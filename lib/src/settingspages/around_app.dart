import 'package:flutter/material.dart';
import 'package:graduation_project/src/settingspages/AboutAppDetails.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD79977),
        title: Text(
          'حول التطبيق',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            children: [
              Text(
                'رحلتي',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.justify,
             // تحديد اتجاه النص
              ),
              const SizedBox(height: 16.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'الاصدار: 1.0.0',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "وصف التطبيق",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 8.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "هذا تطبيق سفر يساعدك على التخطيط لرحلاتك واكتشاف وجهات جديدة . بفضل واجهة سهلة الاستخدام ومجموعة واسعة من الميزات، فهو يهدف إلى جعل تجربة سفرك سلسة وممتعه",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "المطورين",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 8.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ' جهاد & رحاب  & هدير & الاء & فاطمه & هند & ساره ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'تواصل بنا',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 8.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'البريد الإلكتروني:  trip-Email@example.com',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'الهاتف: +1 123-456-7890',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 70.0,
                  vertical: 50.0,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutAppDetails(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFD79977),
                      borderRadius: BorderRadius.circular(10.0), // تحديد الحواف الدائرية
                    ),
                    child: Center(
                      child: const Text(
                        'للمزيد من المعلومات',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
