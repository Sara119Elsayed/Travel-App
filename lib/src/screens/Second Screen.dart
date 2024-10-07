import 'package:flutter/material.dart';
import 'package:graduation_project/src/screens/login_screen.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome_images/p3.png'), // استبدل 'background_image.jpg' بمسار صورتك
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: () {
                      // اقتران زر الانتقال بالصفحة الثانية هنا
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent), // جعل الخلفية شفافة
                      elevation: MaterialStateProperty.all<double>(0), // إزالة الظل
                      overlayColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.1)), // تعيين لون الحدود عند التحويم
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // تعيين شكل الحواف
                          side: BorderSide(color: Color(0xFFD79977), width: 2), // تعيين لون الحدود
                        ),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                      ),
                    ),
                    child: Text('تخطى' ,
                      style:TextStyle(
                        color: Color(0xFF6E4F45),
                        fontSize: 24,
                      ),)
                ),
              ),
            ),
          ),



          Center(
            child: Container(
              width: 318,
              height: 313,
              padding: EdgeInsetsDirectional.all (20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'حدد وجهتك السياحيه',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF6E4F45),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'من خلال التعرف على طقس الاماكن التى تريد الذهاب اليها ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20), // مسافة بين النص والزر
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // اقتران زر الانتقال بالصفحة الثانية هنا
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => ThirdScreen()),
                  //     );
                  //   },
                  //   style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD79977)),
                  //     textStyle: MaterialStateProperty.all<TextStyle>(
                  //       TextStyle(
                  //         color: Colors.black, // لون النص
                  //         fontSize: 24, // حجم النص
                  //       ),
                  //     ),
                  //     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  //       EdgeInsets.symmetric(vertical: 12, horizontal: 60), // حجم الزر
                  //     ),
                  //   ),
                  //   child: Text('التالى'
                  //   ),
                  // ),

                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
}
