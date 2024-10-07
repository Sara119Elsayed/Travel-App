import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/src/screens/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;
  bool _agreedToTerms = false; // تتبع موافقة المستخدم على الشروط والأحكام

  Future signUp() async {
    if (PasswordConfirmed()) {
      try {
        // تسجيل المستخدم باستخدام بريده الإلكتروني وكلمة المرور
        final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // إضافة مستخدم جديد إلى Firestore مع اسمه وبريده الإلكتروني
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'name': _nameController.text.trim(),
          'sender': _emailController.text.trim(),
        });

        // انتقال إلى الشاشة التالية بعد التسجيل بنجاح
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (c) => Auth()),
        );
      } catch (e) {
        print("Failed to sign up: $e");
      }
    }
  }


  bool PasswordConfirmed() {
    return _passwordController.text.trim() == _confirmpasswordController.text.trim();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome_images/p7.png'),
            fit: BoxFit.cover, // لتغطية الشاشة بالكامل
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //image

                  SizedBox(height: 20),
                  //title
                  Text(
                    'انشاء حساب جديد',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //subtitle
                  Text(
                    'مرحبا!قم بانشاء حسابك',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 20,
                    ),
                  ),

                  SizedBox(height: 50),

                  //name textfeild
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
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'الاسم بالكامل',
                            suffixIcon: Icon(Icons.person,color: Color(0xFFD79977),),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

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
                            suffixIcon: Icon(Icons.email,color: Color(0xFFD79977),),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  //password textfield
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
                          obscureText: _passwordObscured,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'كلمة مرور قوية',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordObscured ? Icons.lock : Icons.lock_open,
                                color: _passwordObscured ? Color(0xFFD79977) : Color(0xFFD79977),
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordObscured = !_passwordObscured;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  //confirm password textfield
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
                          controller: _confirmpasswordController,
                          obscureText: _confirmPasswordObscured,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'تأكيد كلمة المرور',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmPasswordObscured ? Icons.lock : Icons.lock_open,
                                color: _confirmPasswordObscured ? Color(0xFFD79977) : Color(0xFFD79977),
                              ),
                              onPressed: () {
                                setState(() {
                                  _confirmPasswordObscured = !_confirmPasswordObscured;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Agree to terms checkbox
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _agreedToTerms,
                          onChanged: (newValue) {
                            setState(() {
                              _agreedToTerms = newValue!;
                            });
                          },
                          checkColor: Colors.white,
                        ),
                        Expanded(
                          child: Text(
                            'من خلال تحديد هذا المربع فإنك توافق على الشروط والأحكام الخاصه بنا  ',
                            style: TextStyle(color: Colors.white),

                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),

                  //sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFFD79977),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'قم بتسجيل الدخول',
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
                        'لديك حساب؟',
                        style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          'تسجيل الدخول',
                          style: GoogleFonts.robotoCondensed(
                            color: Color(0xFFD79977),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
