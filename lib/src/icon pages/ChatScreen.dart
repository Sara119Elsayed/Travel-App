import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final CollectionReference _usersRef = FirebaseFirestore.instance.collection('users');
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD79977),
        title: Text(
          'محادثة جماعية',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _usersRef.orderBy('timestamp').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('لا توجد بيانات'));
                  }

                  List<Widget> chatMessages = [];
                  for (var user in snapshot.data!.docs) {
                    var data = user.data() as Map<String, dynamic>;
                    if (data.containsKey('chats') && data['chats'] is List) {
                      List<dynamic> messages = data['chats'];
                      for (var message in messages) {
                        bool isMe = _user != null && user.id == _user!.uid;
                        DateTime messageTimestamp = data['timestamp'] != null
                            ? (data['timestamp'] as Timestamp).toDate()
                            : DateTime.now(); // Provide a default value if timestamp is null
                        chatMessages.add(
                          ChatMessage(
                            chatId: user.id,
                            senderName: data['name'] ?? '', // تأكد من عدم رجوع قيمة null هنا
                            text: message ?? '', // تأكد من عدم رجوع قيمة null هنا
                            profileImageUrl: data['profileImageUrl'] ?? '', // تأكد من عدم رجوع قيمة null هنا
                            isMe: isMe,
                            timestamp: messageTimestamp,
                            onDelete: () => _deleteMessage(user.id, message),
                            onEdit: (newText) => _editMessage(user.id, message, newText),
                          ),
                        );
                      }
                    }
                  }

                  return ListView(
                    children: chatMessages,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: 'اكتب رسالة...'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      if (_controller.text.isNotEmpty) {
                        await _usersRef.doc(_user?.uid).update({
                          'chats': FieldValue.arrayUnion([_controller.text]),
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Define delete message function
  void _deleteMessage(String chatId, String message) {
    FirebaseFirestore.instance.collection('users').doc(chatId).update({
      'chats': FieldValue.arrayRemove([message]),
    });
  }

  // Define edit message function
  void _editMessage(String chatId, String oldMessage, String newMessage) {
    FirebaseFirestore.instance.collection('users').doc(chatId).update({
      'chats': FieldValue.arrayRemove([oldMessage]),
    }).then((_) {
      FirebaseFirestore.instance.collection('users').doc(chatId).update({
        'chats': FieldValue.arrayUnion([newMessage]),
      });
    });
  }
}

class ChatMessage extends StatefulWidget {
  final String chatId;
  final String senderName;
  final String text;
  final String profileImageUrl;
  final bool isMe;
  final DateTime timestamp;
  final Function() onDelete;
  final Function(String newText) onEdit;

  ChatMessage({
    required this.chatId,
    required this.senderName,
    required this.text,
    required this.profileImageUrl,
    required this.isMe,
    required this.timestamp,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  TextEditingController _editController = TextEditingController();
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _editController.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!widget.isMe)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child:CircleAvatar(
                  backgroundImage: widget.profileImageUrl != null && widget.profileImageUrl.isNotEmpty
                      ? NetworkImage(widget.profileImageUrl)
                      : null,
                  child: widget.profileImageUrl == null || widget.profileImageUrl.isEmpty
                      ? Text(widget.senderName[0])
                      : null,
                )
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: widget.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (!widget.isMe)
                    Text(
                      widget.senderName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 4.0),
                  Container(
                    constraints: BoxConstraints(maxWidth: 250),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: widget.isMe
                          ? Color(0xFFD79977)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.text,
                          style: TextStyle(
                            color: widget.isMe ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 4.0),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment:
                    widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Text(
                        _formatTimestamp(widget.timestamp),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (widget.isMe && _isHovering) ...[
                        IconButton(
                          icon: Icon(Icons.edit, size: 18),
                          onPressed: () {
                            _showEditDialog();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, size: 18),
                          onPressed: () {
                            _confirmDeleteMessage();
                          },
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (widget.isMe) SizedBox(width: 4.0),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تعديل الرسالة'),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(hintText: 'أدخل نصاً جديداً'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onEdit(_editController.text); // Call onEdit from widget
                Navigator.pop(context);
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('حذف الرسالة'),
          content: Text('هل أنت متأكد من حذف هذه الرسالة؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onDelete(); // Call onDelete from widget
                Navigator.pop(context);
              },
              child: Text('حذف'),
            ),
          ],
        );
      },
    );
  }
}
