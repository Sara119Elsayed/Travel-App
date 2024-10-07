class Landmark {
  final int id;
  final String name;
  final String imageUrl;
  final Map<String, int> prices;
  final String governorate;

  Landmark({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.prices,
    required this.governorate,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) {
    Map<String, int> prices = {};
    final List<String> governorates = [
      'القاهرة', 'الجيزة', 'الفيوم', 'الاقصر', 'اسوان',
      'الاسكندرية', 'دمياط', 'المنصورة', 'الاسماعيلية', 'بورسعيد'
    ];

    for (var governorate in governorates) {
      if (json.containsKey('price from $governorate')) {
        prices[governorate] = json['price from $governorate'];
      }
    }

    return Landmark(
      id: json['landmark_id'] as int,
      name: json['name'] as String,
      imageUrl: json['image_URL'] as String,
      prices: prices,
      governorate: json['Governorate to visit'] as String,
    );
  }
}
