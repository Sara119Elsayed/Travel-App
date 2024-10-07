import 'package:flutter/material.dart';

class HotelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة الفنادق'),
      ),
      body: Center(
        child: Text(
          'هذه صفحة الفنادق',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
