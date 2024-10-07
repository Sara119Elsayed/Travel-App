import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'سياسة الخصوصية'),
        backgroundColor: Color(0xFFD79977),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            Text(
              '• شكرًا لاستخدامك لتطبيقنا! تهدف هذه السياسة إلى شرح كيفية جمع واستخدام وحماية المعلومات التي نجمعها منك عند استخدام تطبيقنا.',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10),
            Text(
              '• المعلومات التي نجمعها: عند استخدام التطبيق، قد نطلب منك توفير بعض المعلومات الشخصية التي يمكن استخدامها للتعرف عليك. يمكن أن تشمل هذه المعلومات على سبيل المثال اسم المستخدم والبريد الإلكتروني.',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10),
            Text(
              '• كيف نستخدم المعلومات: نحن نستخدم المعلومات التي نجمعها لتخصيص تجربتك وتحسين خدماتنا. قد نستخدم المعلومات أيضًا لإرسال رسائل إلكترونية دورية تتعلق بتحديثات التطبيق وعروضنا الخاصة.',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10),
            Text(
              '• حماية المعلومات: نحن نقدر ثقتك بنا في التعامل بشكل آمن مع معلوماتك الشخصية، ولذلك نحن نتخذ إجراءات ملائمة لحماية المعلومات التي تقدمها.',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10),
            Text(
              '• مشاركة المعلومات مع أطراف ثالثة: نحن لا نبيع أو نتاجر بمعلوماتك الشخصية. قد نقوم بمشاركة بعض المعلومات مع أطراف ثالثة فقط عند الضرورة لتقديم الخدمات التي تطلبها.',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10),
            Text(
              '• تغييرات في سياسة الخصوصية: قد نقوم بتحديث هذه السياسة من وقت لآخر، وسيتم نشر أي تغييرات هنا. يرجى مراجعة السياسة بانتظام للبقاء على اطلاع.',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10),
            Text(
              '• اتصل بنا: إذا كان لديك أي أسئلة حول سياسة الخصوصية أو تعاملنا مع معلوماتك الشخصية، يرجى الاتصال بنا.',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
