import 'package:flutter/material.dart';
import 'package:graduation_project/src/screens/login_screen.dart';

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome_images/p4.png'), // استبدل 'background_image.jpg' بمسار صورتك
                fit: BoxFit.cover,
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
                    'استمتع برحلتك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF6E4F45),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 9),
                  Text(
                    'من خلال اختيار افضل الأماكن بناءً على ميزانية محددة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 13), // مسافة بين النص والزر
                  ElevatedButton(
                    onPressed: () {
                      // اقتران زر الانتقال بالصفحة الثانية هنا
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD79977)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                          color: Colors.black, // لون النص
                          fontSize: 24, // حجم النص
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 8, horizontal: 35), // حجم الزر
                      ),
                    ),
                    child: Text('ابدء الان'
                    ),
                  ),

                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
}
