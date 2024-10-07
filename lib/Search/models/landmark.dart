class Landmark {
  final int id;
  final String name;
  final String imageUrl;
  final String governorate;
  final String description;
  final String category; // New field for category
  double rating;

  Landmark({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.governorate,
    required this.description,
    required this.category, // Initialize the new field
    this.rating = 0.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'landmark_id': id,
      'name': name,
      'image_URL': imageUrl,
      'Governorate to visit': governorate,
      'Des': description,
      'category': category, // Serialize the new field
      'rating': rating,
    };
  }

  factory Landmark.fromJson(Map<String, dynamic> json) {
    return Landmark(
      id: json['landmark_id'] ?? 0,
      name: json['name'] ?? 'No Name',
      imageUrl: json['image_URL'] ?? 'https://via.placeholder.com/150',
      governorate: json['Governorate to visit'] ?? 'Unknown',
      description: json['Des'] ?? 'No Description',
      category: json['category'] ?? 'Other', // Parse the new field
      rating: json['rating']?.toDouble() ?? 0.0,
    );
  }
}
