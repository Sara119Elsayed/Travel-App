import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NotificationManagementPage extends StatefulWidget {
  @override
  _NotificationManagementPageState createState() => _NotificationManagementPageState();
}

class _NotificationManagementPageState extends State<NotificationManagementPage> {
  final TextEditingController _notificationController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إدارة الإشعارات'),
        backgroundColor: Color(0xFFD79977),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'عنوان الإشعار',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _notificationController,
              decoration: InputDecoration(
                labelText: 'نص الإشعار',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD79977)),
              ),
              child: Text('اختر تاريخ الإشعار',),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addNotification(
                  _titleController.text.trim(),
                  _notificationController.text.trim(),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD79977)),
              ),
              child: Text('إرسال الإشعار'),
            ),
            SizedBox(height: 20),
            Text(
              'الإشعارات المرسلة:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final data = documents[index].data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data['title']),
                        subtitle: Text(data['notification']),
                        trailing: Text(_formatTimestamp(data['timestamp'])),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatTimestamp(Timestamp timestamp) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formattedDate = formatter.format(timestamp.toDate());
    return formattedDate;
  }

  void _addNotification(String title, String notification) {
    FirebaseFirestore.instance.collection('notifications').add({
      'title': title,
      'notification': notification,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('تم إرسال الإشعار بنجاح.'),
      ));
      _titleController.clear();
      _notificationController.clear();
      setState(() {
        _selectedDate = null;
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('حدث خطأ أثناء إرسال الإشعار: $error'),
        backgroundColor: Colors.red,
      ));
    });
  }
}
