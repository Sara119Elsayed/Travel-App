import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/src/Admin/Admin.dart';
import 'package:graduation_project/src/screens/auth.dart';
import 'package:graduation_project/src/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscured = true; // حالة المرور: مخفي أو ظاهر

  // الدالة التي تقوم بتغيير حالة المرور
  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    Navigator.of(context).push(
      MaterialPageRoute(builder: (c) {
        return Auth();
      }),
    );
  }

  void openSignUpScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (c) {
        return SignUpScreen();
      }),
    );
  }

  void showAdminLoginDialog() {
    String enteredPassword = "123321"; // تخزين كلمة المرور المدخلة
    bool showPassword = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "تسجيل الدخول كمسؤول",
            style: TextStyle(
              color: Color(0xFFD79977), // لون مخصص بناءً على القيمة الهكساديسيمال
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(

                obscureText: !showPassword,
                onChanged: (value) {
                  enteredPassword = value; // تخزين القيمة المدخلة في كلمة المرور
                },
                decoration: InputDecoration(
                  labelText: "كلمة المرور",
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xFFD79977), // يمكنك تغيير لون الأيقونة هنا
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق الرسالة العائمة
              },
              child: Text("إلغاء"
              ,style: TextStyle(
        color: Color(0xFFD79977), // اللون المخصص هنا
        ),),
            ),
            TextButton(
              onPressed: () {
                if (enteredPassword == "123") {
                  Navigator.of(context).pop(); // إغلاق الرسالة العائمة
                  // تسجيل الدخول كمسؤول - افتح صفحة الأدمن
                  // هنا يمكنك استخدام مثلاً:
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminScreen()));
                } else {
                  // عرض رسالة "كلمة المرور خاطئة"
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("كلمة المرور خاطئة"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text("تم",
        style: TextStyle(
        color: Color(0xFFD79977), // اللون المخصص هنا
        ),
        ))],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // جعل خلفية الصفحة شفافة
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome_images/p5.png'), // رابط الصورة
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    //title
                    Text(
                      'تسجيل الدخول',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //subtitle
                    Text(
                      'اهلا بعودتك سجل الدخول لحسابك',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 50),

                    //email textfeild
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'البريد الالكترونى',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.email, color: Color(0xFFD79977),), // تغيير لون الأيقونة
                                onPressed: () {}, // يمكنك إضافة وظيفة للضغط هنا
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    //passwordtext
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _isObscured, // يستخدم الحالة المحلية هنا
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'كلمة المرور',
                              suffixIcon: IconButton(
                                icon: _isObscured ? Icon(Icons.lock, color: Color(0xFFD79977),) : Icon(Icons.lock_open, color: Color(0xFFD79977),), // تغيير لون الأيقونة
                                onPressed: _togglePasswordVisibility, // يقوم بتغيير حالة المرور عند الضغط
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    //sign in button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: GestureDetector(
                        onTap: signIn,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFFD79977),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'تسجيل الدخول',
                              style: GoogleFonts.robotoCondensed(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    //text:sign up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ليس لديك حساب؟',
                          style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: openSignUpScreen,
                          child: Text(
                            'سجل الان',
                            style: GoogleFonts.robotoCondensed(
                                color: Color(0xFFD79977),
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    //text: admin login
                    GestureDetector(
                      onTap: showAdminLoginDialog,
                      child: Text(
                        'تسجيل الدخول كمسؤول',

                        style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.bold,
                          color:Color(0xFFD79977),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
