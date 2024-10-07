import 'package:flutter/material.dart';

class AboutAppDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD79977),
        title: Text(
          'معلومات عن التطبيق',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تبسيط تخطيط الرحلات:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 8),
            Text(
              '"رحلتي" يهدف إلى تبسيط عملية تخطيط الرحلات من خلال توفير أدوات للمستخدمين لإنشاء جداول زمنية مخصصة بناءً على تفضيلاتهم واهتماماتهم.',
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 16),
            Text(
              'تعزيز الاستكشاف:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 8),
            Text(
              'يسعى التطبيق إلى تعزيز تجربة الاستكشاف من خلال تقديم توصيات قائمة على الموقع للمعالم السياحية القريبة والمطاعم والأنشطة.',
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 16),
            Text(
              'تعزيز إدارة الميزانية:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 8),
            Text(
              'يشمل التطبيق ميزات لمساعدة المستخدمين على إدارة ميزانية سفرهم بفعالية، مثل تتبع النفقات، وتقدير التكاليف للأنشطة، وتقديم توصيات تناسب الميزانية.',
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 16),
            Text(
              'توفير أقصر الطرق إلى المناطق السياحية:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 8),
            Text(
              'يتضمن التطبيق ميزات لتوفير أقصر الطرق للوصول إلى المناطق السياحية.',
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 16),
            Text(
              'تقديم شرح كافٍ وتوفير جميع المعلومات عن المنطقة التي تم زيارتها:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 8),
            Text(
              'يأخذ التطبيق في الاعتبار تقديم شرح كافٍ وتوفير جميع المعلومات عن المنطقة التي تمت زيارتها.',
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 16),
            Text(
              'إنتاج اقتراحات رحلات مخصصة:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 8),
            Text(
              'ينتج التطبيق اقتراحات رحلات مخصصة بناءً على رغبات المسافر وقدرته المالية، مما يجعل من السهل عليه تخطيط رحلاته بشكل شخصي ومريح.',
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 16),
            Text(
              'توفير معلومات عن حالة الطقس:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 8),
            Text(
              'تتضمن ميزة توفير معلومات عن حالة الطقس في المناطق السياحية المختلفة. يمكن للمستخدمين تخطيط رحلاتهم بناءً على معرفة توقعات الطقس للمكان الذي ينوون زيارته.',
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 16),
            Text(
              'عرض مقاييس ومعلومات مختلفة تتعلق بالطقس لليوم الحالي:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 8),
            Text(
              'يعرض التطبيق مقاييس ومعلومات متنوعة تتعلق بالطقس لليوم الحالي. تشمل التفاصيل الرئيسية التي يمكنني توفيرها:',
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 8),
            Text(
              '- درجة الحرارة\n'
                  '- مستوى الرطوبة\n'
                  '- مؤشر الأشعة فوق البنفسجية (UV index)\n'
                  '- سرعة الرياح\n'
                  '- احتمالية هطول الأمطار\n'
                  '- وقت شروق الشمس',
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 16),
            Text(
              'توفير خريطة للبحث عن الأماكن ورسم خط من الموقع الحالي إلى الوجهة:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 8),
            Text(
              'تتضمن الخريطة إمكانية البحث عن مكان ورسم خط من الموقع الحالي إلى الوجهة وتحديد أقرب المطاعم والمعابد والمتاحف بناءً على الموقع الحالي. كما تعرض الخريطة معالم ومواقع مختلفة في المنطقة الحضرية من غير حروف.',
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
