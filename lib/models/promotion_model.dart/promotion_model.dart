class PromotionModel {
  final String name;
  final int discountPercent;
  final String description;
  final DateTime expDate;

  PromotionModel({
    required this.name,
    required this.discountPercent,
    required this.description,
    required this.expDate,
  });
}
