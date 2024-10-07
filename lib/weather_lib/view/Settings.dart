import 'package:flutter/material.dart';
import 'package:graduation_project/weather_lib/view/SearchPage.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool ShowWeather = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الإعدادات", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xFFD79977),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Text("وحدات القياس", style: TextStyle(color: Colors.black54)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromRGBO(245, 238, 238, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text("درجة الحرارة", style: TextStyle(color: Colors.black, fontSize: 18)),
                      SizedBox(height: 5),
                      Text("درجة مئوية", style: TextStyle(color: Color(0xFFD79977), fontSize: 14)),
                      Divider(thickness: 2),
                      SizedBox(height: 10),
                      Text("الرياح", style: TextStyle(color: Colors.black, fontSize: 18)),
                      SizedBox(height: 5),
                      Text("كيلومترات في الساعة (كم/س)", style: TextStyle(color: Color(0xFFD79977), fontSize: 14)),
                      Divider(thickness: 2),
                      SizedBox(height: 10),
                      Text("ضغط الهواء", style: TextStyle(color: Colors.black, fontSize: 18)),
                      SizedBox(height: 5),
                      Text("هيكتوباسكال (ه.ب)", style: TextStyle(color: Color(0xFFD79977), fontSize: 14)),
                      Divider(thickness: 2),
                      SizedBox(height: 10),
                      Text("الرؤية", style: TextStyle(color: Colors.black, fontSize: 18)),
                      SizedBox(height: 5),
                      Text("كيلومترات (كم)", style: TextStyle(color: Color(0xFFD79977), fontSize: 14)),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromRGBO(245, 238, 238, 1),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SearchPageweather(),
                  ));
                },
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text("عن الطقس", style: TextStyle(color: Colors.black, fontSize: 18)),
                    Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_outlined)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}