import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String _confirmationMessage = '';
  File? _image;
  String? _imageUrl;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    // استرجاع رابط الصورة المخزنة للمستخدم الحالي من Firestore عند تحميل الصفحة
    fetchProfileImage();
  }

  Future<void> fetchProfileImage() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    setState(() {
      _imageUrl = snapshot.data()?['gs://fir-auth-app-cf9fa.appspot.com'];
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(fileName);
      await ref.putFile(imageFile);
      String imageUrl = await ref.getDownloadURL();
      // تحديث رابط الصورة في Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'profileImageUrl': imageUrl,
      });
      setState(() {
        _image = imageFile;
        _imageUrl = imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            LineAwesomeIcons.angle_left,
            color: Colors.black,
          ),
        ),
        title: Center(
          child: Text(
            "تعديل الصفحة الشخصية",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Color(0xFFD79977),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xFFFBF8F1),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _image != null
                              ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )
                              : _imageUrl != null
                              ? Image.network(
                            _imageUrl!,
                            fit: BoxFit.cover,
                          )
                              : Image.asset(
                            "assets/images/profile.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xFFD79977),
                            ),
                            child: const Icon(
                              LineAwesomeIcons.camera,
                              color: Color(0xFFFBF8F1),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "تعديل الاسم",
                    prefixIcon: Icon(LineAwesomeIcons.user, color: Color(0xFFD79977)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFD79977),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "تعديل الايميل",
                    prefixIcon: Icon(LineAwesomeIcons.envelope_1, color: Color(0xFFD79977)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD79977)),
                    ),
                  ),
                ),


                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _confirmationMessage = 'تم تعديل الملف الشخصي بنجاح!';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم تعديل الملف الشخصي بنجاح!'),
                          backgroundColor: Color(0xFFD79977),
                          duration: Duration(seconds: 3),
                        ),
                      );




                      // ارسال البيانات إلى قاعدة البيانات هنا
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD79977),
                      onPrimary: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "تعديل الملف الشخصى",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
