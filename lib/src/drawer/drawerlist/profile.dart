import 'package:flutter/material.dart';
import 'package:graduation_project/bottom_navigation_bar/bottom_navigator.dart';
import 'package:graduation_project/src/drawer/drawerlist/settings.dart';
import 'package:graduation_project/src/drawer/drawerlist/updateprofile.dart';
import 'package:graduation_project/src/screens/login_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  String? userName;
  String? profileImageUrl; // تخزين عنوان URL لصورة المستخدم

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  // دالة لاسترجاع معلومات المستخدم وعنوان URL لصورة المستخدم
  void getUserProfile() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          userName = documentSnapshot.get('name');
          profileImageUrl = documentSnapshot.get('profileImageUrl');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الصفحة الشخصية'),
        backgroundColor: Color(0xFFD79977),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: profileImageUrl != null
                                ? Image.network(
                              profileImageUrl!,
                              fit: BoxFit.cover,
                            )
                                : const Image(
                              image: AssetImage("assets/images/profile.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xFFD79977),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const UpdateProfileScreen()),
                                );
                              },
                              icon: const Icon(
                                LineAwesomeIcons.alternate_pencil,
                                color: Color(0xFFFBF8F1),
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userName ?? 'جاري التحميل...',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      user.email!,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD79977),
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const UpdateProfileScreen()),
                          );
                        },
                        child: const Text(
                          "تعديل الملف",
                          style: TextStyle(
                            color: Color(0xFFFBF8F1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 10),
                    ProfileMenuWidget(
                      title: "الإعدادات",
                      icon: LineAwesomeIcons.cog,
                      onPress: () {

                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));


                      },
                    ),
                    ProfileMenuWidget(
                      title: "حذف الحساب ",
                      icon: LineAwesomeIcons.user_check,
                      onPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('تأكيد حذف الحساب'),
                                content: Text('هل أنت متأكد أنك تريد حذف حسابك؟'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      try {
                                        await FirebaseAuth.instance.currentUser!.delete(); // حذف الحساب الحالي
                                        // يتم إعادة توجيه المستخدم إلى شاشة تسجيل الدخول بنجاح
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => LoginScreen()));
                                      } catch (error) {
                                        print('Error deleting account: $error');
                                        // يمكنك هنا إظهار رسالة خطأ للمستخدم
                                      }
                                    },

                                    child: Text('نعم'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // هنا يتم استدعاء الدالة المسؤولة عن حذف الحساب
                                      Navigator.pop(context); // إغلاق مربع الحوار
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("لقد تم حذف حسابك بنجاح."),
                                          backgroundColor:Color(0xFFD79977),  // لون الخلفية للرسالة العائمة
                                        ),
                                      );
                                    },

                                    child: Text('لا'),
                                  ),
                                ],
                              );
                            },
                          );
                      },
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    ProfileMenuWidget(
                      title: "تسجيل الخروج",
                      icon: LineAwesomeIcons.alternate_sign_out,
                      textColor: Color(0xFFD79977),
                      endicon: false,
                      onPress: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));

                      },
                    ),
                  ],
                ),
              ),
              // الأقسام الأخرى من واجهة المستخدم...
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endicon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endicon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color(0xFFFBF8F1),
        ),
        child: Icon(
          icon,
          color: Color(0xFFD79977),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor),
      ),
      trailing: endicon
          ? Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color(0xFFFBF8F1),
        ),
        child: Icon(
          LineAwesomeIcons.angle_left,
          color: Color(0xFFD79977),
          size: 18,
        ),
      )
          : null,
    );
  }
}
