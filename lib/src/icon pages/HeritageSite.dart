import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HeritageSitePage extends StatefulWidget {
  @override
  State<HeritageSitePage> createState() => _TestState();
}

class _TestState extends State<HeritageSitePage> {
  String? body = "";
  Map<String, dynamic> result = {};
  File? _file;

  Future<void> chooseImageSource() async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('استوديو الصور'),
                onTap: () async {
                  await pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('الكاميرا'),
                onTap: () async {
                  await pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final myfile = await ImagePicker().pickImage(source: source);
    if (myfile == null) return;

    setState(() {
      _file = File(myfile.path);
    });
  }

  Future<void> predict() async {
    if (_file == null) return;
    print(_file);
    final url = 'http://192.168.8.40:5000/api';

    final Map<String, dynamic> data = {
      'base64': base64Encode(_file!.readAsBytesSync()),
    };

    print(data);

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json',  'Accept': 'application/json'},
        body: jsonEncode(data),
      );
      print("After reading file");

      if (response.statusCode == 200) {
        setState(() {
          result = jsonDecode(response.body) as Map<String, dynamic>;
        });
        print("After reading file");
        print(result);
        print('Update successful');
      } else {
        print('Update failed. Status code: ${response.statusCode}');
      }
    } catch (exception) {
      print('Error occurred: $exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD79977),
        title: Text('تعرف على المعالم المحيطة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: chooseImageSource,
                  child: Material(
                    elevation: 5, // زيادة الظل
                    borderRadius: BorderRadius.circular(20), // تحديد الحواف الدائرية
                    child: Container(
                      width: 400,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFD79977), // تحديد لون الحواف
                          width: 2, // تحديد سمك الحاف
                        ),// تحديد الحواف الدائرية
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: _file == null
                                  ? Icon(Icons.camera_alt, size: 80, color: Colors.black45)
                                  : Image.file(_file!, fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: TextButton(
                              onPressed: chooseImageSource,
                              child: Text(
                                "ادخل صورة جديده",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20, // تحديد الوزن هنا
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor:  Color(0xFFD79977),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),



                result.entries.isEmpty ? Text("") : Column(
                  children: [
                    SizedBox(height: 20),
                    Text("المعلم السياحي: ${result['landmark']}", style: TextStyle(color: Colors.black)),
                    SizedBox(height: 10),
                    Text("الوصف: ${result['desc']}", style: TextStyle(color: Colors.black)),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[

                    TextButton(
                      onPressed: predict,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,), // تحديد الهامش الداخلي للزر
                        child: Text(
                          "تعرف",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFD79977),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // زيادة انحناء الحواف
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
    );
  }
}
