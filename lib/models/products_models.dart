class Sproduct {
  final String brand;
  final String title;
  final double rating;
  final int reviews;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercent;
  final double bestPrice;
  final String deliveryDate;
  final bool isExpress;

  const Sproduct({
    required this.brand,
    required this.title,
    required this.rating,
    required this.reviews,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercent,
    required this.bestPrice,
    required this.deliveryDate,
    required this.isExpress,
  });
}
