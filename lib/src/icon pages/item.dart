class Item {
  final String name;
  final String id;
  bool isFavorite;
  final String imageUrl;
  final String placeInfo; // New field for place information

  Item({
    required this.name,
    required this.id,
    required this.isFavorite,
    required this.imageUrl,
    required this.placeInfo, // Updated constructor to include place info
  });
}

String text = ""; // Initialize an empty search text

List<Item> itemList = [
  Item(
    name: "هرم هوارة", // Place name
    id: "الأهرامات",
    isFavorite: false,
    imageUrl: "assets/images/search/p1.jpg",
    placeInfo:
    "هو أحد أهرامات مصر. بناه فرعون مصر إمنمحات الثالث من ملوك الأسرة 12 بقرية هوارة على بعد 9 كم جنوب شرق مدينة الفيوم.",
  ),
  Item(
    name: "هرم زوسر", // Place name
    id: "الأهرامات",
    isFavorite: false,
    imageUrl: "assets/images/search/p2.jpg",
    placeInfo:
    " بُني خلال القرن 27 ق.م لدفن الفرعون زوسر؛ بناه له وزيره إمحوتب. وكان المهندس والطبيب أمحتب هو المهندس الأساسي للمجموعة الجنائزية الواسعة في فناء الهرم",
  ),
  Item(
    name: "متحف الفن الإسلامي", // Place name
    id: "المتاحف",
    isFavorite: false,
    imageUrl: "assets/images/search/m1.jpeg",
    placeInfo:
    "من أكبر متاحف مصر و المتاحف الإسلامية في العالم وملاذًا لأغنى عرض للتراث الثقافي والفني للحضارة الإسلامية، حيث يضم أكثر من 100 ألف قطعة فنية وأثرية من شتى بقاع العالم،",
  ),
  Item(
    name: "متحف الرمال", // Place name
    id: "المتاحف",
    isFavorite: false,
    imageUrl: "assets/images/search/m2.png",
    placeInfo:
    "يضم متحف الرمال مجموعة من المنحوتات الرملية التي تصور شخصيات تاريخية وثقافية بارزة مثل الملكة كليوباترا ومحمد الفاتح، بالإضافة إلى مجسمات تمثل عجائب الدنيا السبع.",
  ),
  Item(
    name: "المقبرة الملكية لإخناتون", // Place name
    id: "المقابر",
    isFavorite: false,
    imageUrl: "assets/images/search/t1.jpg",
    placeInfo:
    "المقبرة الملكية لإخناتون أو مقبرة 55 هي مقبرة عثر عليه في العمارنة، ووجدت فيها مومياء تلبس الحلي الذهبية. وبعد بحوث واختبارات لمعرفة صاحب المومياء إتضح أنها مومياء الفرعون إخناتون ",
  ),
  Item(
    name: "مقبرة 62", // Place name
    id: "المقابر",
    isFavorite: false,
    imageUrl: "assets/images/search/t2.jpg",
    placeInfo:
    "مقبرة توت عنخ آمون أو مقبرة 62 حسب الترميز العلمي وتعرف عالميًا باسم (KV 62)، وهي المقبرة الخاصة بالفرعون توت عنخ آمون، تقع بوادي الملوك بمصر على ضفة نهر النيل الغربية المقابلة لمدينة الأقصر",
  ),
  Item(
    name: "تمثال رمسيس الثاني", // Place name
    id: "تماثيل",
    isFavorite: false,
    imageUrl: "assets/images/search/s1.jpg",
    placeInfo:
    "هو تمثال يبلغ عمره 3200 عام يمثل رمسيس الثاني. ويصور التمثال رمسيس الثاني واقفا. تم اكتشاف التمثال العام 1820 من خلال المستكشف «جيوفاني باتيستا كافيليا» في «معبد ميت رهينة العظيم» قرب ممفيس في مصر.",
  ),
  Item(
    name: "تمثال ميرت آمون", // Place name
    id: "تماثيل",
    isFavorite: false,
    imageUrl: "assets/images/search/s2.jpg",
    placeInfo:
    " تمثال يقع في مدينة أخميم في محافظة سوهاج، مصر وهو أكبر تمثال يخص امرأة في مصر. يشتهر بين أهالي المنطقة بتمثال العروسة. يبلغ ارتفاع التمثال 12 مترًا ووزنه 31 طنًا",
  ),

  // Add more items here if needed
];
