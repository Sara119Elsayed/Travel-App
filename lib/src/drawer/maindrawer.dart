import 'package:flutter/material.dart';
import 'package:graduation_project/Search/savelandmark.dart';
import 'package:graduation_project/bottom_navigation_bar/bottom_navigator.dart';
import 'package:graduation_project/src/drawer/drawerlist/my_drawer_header.dart';
import 'package:graduation_project/src/drawer/drawerlist/notifications.dart';
import 'package:graduation_project/src/drawer/drawerlist/privacy_policy.dart';
import 'package:graduation_project/src/drawer/drawerlist/profile.dart';
import 'package:graduation_project/src/drawer/drawerlist/send_feedback.dart';
import 'package:graduation_project/src/drawer/drawerlist/settings.dart';
import 'package:graduation_project/src/drawer/drawerlist/stars.dart';
import 'package:graduation_project/src/screens/Welcome%20Screen.dart';
import '../icon pages/FavoritesPage.dart';
import '../icon pages/item.dart';
import '../screens/login_screen.dart';
import 'home.dart';

enum DrawerSections {
  home,
  profile,
  rateApp,
  settings,
  notifications,
  privacyPolicy,
  suggestions,
  logout,
}

class Maindrawer extends StatefulWidget {
  @override
  _MaindrawerState createState() => _MaindrawerState();
}

class _MaindrawerState extends State<Maindrawer> {
  final List<Item> favoriteItems = [];
  var currentPage = DrawerSections.home;


  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.home) {
      container = homePage();
    } else if (currentPage == DrawerSections.profile) {
      container = ProfileScreen();
    } else if (currentPage == DrawerSections.rateApp) {
      container = RateAppPage();
    } else if (currentPage == DrawerSections.settings) {
      container = SettingsPage();
    } else if (currentPage == DrawerSections.notifications) {
      container = NotificationsPage();
    } else if (currentPage == DrawerSections.privacyPolicy) {
      container = PrivacyPolicyPage();
    } else if (currentPage == DrawerSections.suggestions) {
      container = SuggestionsPage();
    } else if (currentPage == DrawerSections.logout) {
      container = WelcomeScreen();
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('رحلتى'),
          backgroundColor: Color(0xFFD79977),
          centerTitle: true,
          actions: [
            IconTheme(
              data: IconThemeData(color:Colors.white,),
              child: IconButton(
                icon: Icon(Icons.favorite),
                onPressed: ()  async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>SavedLandmarksPage(),
                    ),
                  );
                  // if (result != null && result is List<Item>) {
                  //   setState(() {
                  //     //favoriteItems = result;
                  //   });
                  // }
                },
              ),

            ),

            IconButton(

              icon: Icon(Icons.notifications,color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              },
            ),
          ],
        ),
        body: container,
        drawer: Drawer(
          child: Theme(
            data: ThemeData(
              // تحديد لون أيقونة الدراور
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white30,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyHeaderDrawer(),
                      MyDrawerList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget MyDrawerList() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 15),
        child: Align(
          alignment: Alignment.centerRight,

          child: IconTheme(
            data: IconThemeData(color: Colors.black),
            child: Column(
              children: [
                menuItem(
                  DrawerSections.home,
                  Icons.home,
                  "الرئيسية",
                ),
                menuItem(
                  DrawerSections.profile,
                  Icons.person_rounded,
                  "الملف الشخصى",
                ),
                menuItem(
                  DrawerSections.rateApp,
                  Icons.star,
                  "تقييم التطبيق",
                ),
                Divider(),
                menuItem(
                  DrawerSections.settings,
                  Icons.settings_outlined,
                  "الإعدادات",
                ),
                menuItem(
                  DrawerSections.notifications,
                  Icons.notifications_outlined,
                  "الإشعارات",
                ),
                Divider(),
                menuItem(
                  DrawerSections.privacyPolicy,
                  Icons.privacy_tip_outlined,
                  "سياسة الخصوصية",
                ),
                menuItem(
                  DrawerSections.suggestions,
                  Icons.feedback_outlined,
                  "إرسال اقتراحات",
                ),
                Divider(),
                menuItem(
                  DrawerSections.logout,
                  Icons.exit_to_app,
                  "تسجيل الخروج",
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget menuItem(DrawerSections section, IconData icon, String title) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          if (section == DrawerSections.home) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          } else if (section == DrawerSections.profile) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          } else if (section == DrawerSections.rateApp) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RateAppPage()),
            );

          } else if (section == DrawerSections.settings) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          } else if (section == DrawerSections.notifications) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsPage()),
            );
          } else if (section == DrawerSections.privacyPolicy) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
            );
          } else if (section == DrawerSections.suggestions) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SuggestionsPage()),
            );
          } else if (section == DrawerSections.logout) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
