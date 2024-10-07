
import 'package:graduation_project/configrution/Category.dart';
import 'package:graduation_project/configrution/places.dart';


Future<List<Places>> bringThePlaces() async {
  var PlaceList = <Places>[];

  var f1 = Places(PlaceId: 1, PlaceName: "المتحف المصري", PlaceImageName: "assets/images/places/p1.jpg", PlaceCategory: "القاهره", PlacePrice: "150");
  var f2 = Places(PlaceId: 2, PlaceName: "معبد الكرنك", PlaceImageName: "assets/images/places/p2.jpg", PlaceCategory: "الأقصر", PlacePrice: "200");
  var f3 = Places(PlaceId: 3, PlaceName: "محمية رأس محمد", PlaceImageName: "assets/images/places/p3.jpg", PlaceCategory: "شرم الشيخ", PlacePrice: "100");
  var f4 = Places(PlaceId: 4, PlaceName: "متحف الغوص البحري", PlaceImageName: "assets/images/places/p4.jpeg", PlaceCategory: "الغردقة", PlacePrice: "500");
  var f5 = Places(PlaceId: 5, PlaceName: "قلعة قايتباي", PlaceImageName: "assets/images/places/p5.jpg", PlaceCategory: "الإسكندرية", PlacePrice: "240");
  var f6 = Places(PlaceId: 6, PlaceName: "معبد فيلة:", PlaceImageName: "assets/images/places/p6.jpg", PlaceCategory: "أسوان", PlacePrice: "600");
  var f7 = Places(PlaceId: 7, PlaceName: "شاطئ دهب", PlaceImageName: "assets/images/places/p7.jpg", PlaceCategory: "دهب", PlacePrice: "300");
  var f8 = Places(PlaceId: 8, PlaceName: "شاطئ مرسى علم", PlaceImageName: "assets/images/places/p8.jpg", PlaceCategory: "مرسى علم", PlacePrice: "500");
  var f9 = Places(PlaceId: 9, PlaceName: "اهرامات الجيزه", PlaceImageName: "assets/images/places/p9.jpg", PlaceCategory: "الجيزه", PlacePrice: "200");

  PlaceList.add(f1);
  PlaceList.add(f2);
  PlaceList.add(f3);
  PlaceList.add(f4);
  PlaceList.add(f5);
  PlaceList.add(f6);
  PlaceList.add(f7);
  PlaceList.add(f8);
  PlaceList.add(f9);

  return PlaceList;
}

Future<List<Category>> bringTheCategory() async {
  var categoryList = <Category>[];

  var c1 = Category(categoryId: 1, categoryName: "Chicken", categoryImage: "assets/category/chicken.png");
  var c2 = Category(categoryId: 2, categoryName: "Bakery", categoryImage: "assets/category/bakery.png");
  var c3 = Category(categoryId: 3, categoryName: "Fast Place", categoryImage: "assets/category/fastPlace.png");
  var c4 = Category(categoryId: 4, categoryName: "Fish", categoryImage: "assets/category/fish.png");
  var c5 = Category(categoryId: 5, categoryName: "Fruit", categoryImage: "assets/category/fruit.png");
  var c6 = Category(categoryId: 6, categoryName: "Soup", categoryImage: "assets/category/soup.png");
  var c7 = Category(categoryId: 7, categoryName: "Vegetable", categoryImage: "assets/category/vegetable.png");

  categoryList.add(c1);
  categoryList.add(c2);
  categoryList.add(c3);
  categoryList.add(c4);
  categoryList.add(c5);
  categoryList.add(c6);
  categoryList.add(c7);

  return categoryList;
}

