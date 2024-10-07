import 'package:flutter/material.dart';

class RestaurantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة المطاعم'),
      ),
      body: Center(
        child: Text(
          'هذه صفحة المطاعم',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
