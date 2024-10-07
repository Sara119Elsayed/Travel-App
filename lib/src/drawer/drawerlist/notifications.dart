import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الاشعارات'),
        backgroundColor: Color(0xFFD79977),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.separated(
              itemCount: documents.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Color(0xFFD79977),
              ),
              itemBuilder: (context, index) {
                final data = documents[index].data() as Map<String, dynamic>;
                return _buildNotificationItem(
                  title: data['title'],
                  subtitle: data['notification'],
                  date: _formatTimestamp(data['timestamp']),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required String date,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      onTap: () {
        // يمكنك هنا تنفيذ إجراء معين عند النقر على الإشعار
      },
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(timestamp.toDate());
    return formattedDate;
  }
}
