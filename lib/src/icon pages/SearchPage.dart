import 'package:flutter/material.dart';
import 'FavoritesPage.dart';
import 'item.dart'; // Assuming itemList is defined in item.dart

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  String text = ""; // Initialize an empty search text
  List<Item> searchList = [];
  List<Item> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    searchList = itemList;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
        appBar: AppBar(
        backgroundColor: Color(0xFFD79977),
    elevation: 6,
    centerTitle: true,
    title: Text(
    "الاقتراحات",
    style: TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 17,
    ),
    ),
    ),
    body: Column(
    children: [
    Padding(
    padding: const EdgeInsets.all(7),
    child: Container(
    height: 45,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    color: Colors.white,
    ),
    child: TextFormField(
    controller: controller,
    onChanged: (value) {
    setState(() {
    text = value; // Update the search text
    searchList = itemList
        .where((item) => item.name
        .toLowerCase()
        .contains(text.toLowerCase()))
        .toList();
    });
    },
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.search),
    hintText: "ابحث عن اماكن",
    hintStyle: TextStyle(fontSize: 15),
    ),
    ),
    ),
    ),
    Container(
    height: 50,
    color: Colors.white.withOpacity(0.7),
    child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
    SizedBox(width: 10),
    _allItems(""),
    SizedBox(width: 10),
    _singleItem("الأهرامات"),
    SizedBox(width: 10),
    _singleItem("المتاحف"),
    SizedBox(width: 10),
    _singleItem("المقابر"),
    SizedBox(width: 10),
    _singleItem("تماثيل"),
    ],
    ),
    ),
    ),
    Container(
    height: 40,
    width: double.infinity,
    color: Colors.white.withOpacity(0.9),
    child: Padding(
    padding: const EdgeInsets.only(left: 15, top: 3),
    child: Text(
    "ابحث عن : $text",
    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
    ),
    ),
    ),
    Expanded(
    child: ListView.builder(
    itemCount: searchList.length,
    itemBuilder: (context, index) {
    return Column(
    children: [
    Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
    height: 80,
    width: 100,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(3),
    image: DecorationImage(
    image: AssetImage(searchList[index].imageUrl),
    fit: BoxFit.cover,
    ),
    ),
    ),
    SizedBox(width: 16),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    searchList[index].name,
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: Color(0xFFD79977),
    ),
    ),
    SizedBox(height: 8),
    Text(
    searchList[index].placeInfo,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
    fontSize: 14,
    color: Colors.grey,
    ),
    ),
    ],
    ),
    ),
    IconButton(
    icon: Icon(
    searchList[index].isFavorite ? Icons.favorite : Icons.favorite_border,
    color: searchList[index].isFavorite ?   Color(0xFFD79977) : null,
    ),
    onPressed: () {
    setState(() {
    if (!searchList[index].isFavorite) {
    searchList[index].
    isFavorite = true;
    favoriteItems.add(searchList[index]); // إضافة العنصر لقائمة المفضلة
    } else {
      searchList[index].isFavorite = false;
      favoriteItems.removeWhere((item) => item.id == searchList[index].id); // إزالة العنصر من قائمة المفضلة
    }
    });
    },
    ),
    ],
    ),
    ),
      Divider(),
    ],
    );
    },
    ),
    ),
    ],
    ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritePage(favoriteItems: favoriteItems),
                ),
              );
              // التحقق مما إذا كان هناك أي تغيير في قائمة العناصر المفضلة
              if (result != null && result is List<Item>) {
                setState(() {
                  favoriteItems = result;
                });
              }
            },
            child: Icon(Icons.favorite),
            backgroundColor: Color(0xFFD79977),
          ),





        ),
    );
  }

  Widget _allItems(String searchText) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          text = searchText;
          searchList = itemList
              .where((item) => item.id.toLowerCase().contains(text.toLowerCase()))
              .toList();
        });
      },
      style: ElevatedButton.styleFrom(
        elevation: 2,
        primary: Color(0xFFD79977),
      ),
      child: Text(
        'الكل',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _singleItem(String searchText) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          text = searchText;
          searchList = itemList
              .where((item) => item.id.toLowerCase().contains(text.toLowerCase()))
              .toList();
        });
      },
      style: ElevatedButton.styleFrom(
        elevation: 2,
        primary: Color(0xFFD79977),
      ),
      child: Text(searchText, style: TextStyle(color: Colors.white)),
    );
  }
}

