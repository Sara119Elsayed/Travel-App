import 'package:flutter/material.dart';
import 'item.dart';

class FavoritePage extends StatelessWidget {
  final List<Item> favoriteItems;

  FavoritePage({required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFD79977),
        title: Text('المفضلة'),
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(item.name),
                subtitle: Text(item.placeInfo),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(item.imageUrl),
                ),
              ),
              Divider(), // إضافة الفاصل بين كل عنصر والآخر
            ],
          );
        },
      ),
    );
  }
}
