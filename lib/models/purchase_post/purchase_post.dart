class PurchasePost {
  final int id;
  final String title;
  final List<String> petImage;
  final String breed;
  final double price;
  final int percentDiscount;
  final bool isMale;
  final int age;

  PurchasePost({
    required this.id,
    required this.title,
    required this.petImage,
    required this.breed,
    required this.price,
    required this.percentDiscount,
    this.isMale = true,
    this.age = 12,
  });
}
