class ProductModel {
  final String name;
  final String image;
  final double price;
  final double discountPrice;
  bool isFavorite;

  ProductModel({
    required this.name,
    required this.image,
    required this.price,
    required this.discountPrice,
    this.isFavorite = false,
  });
}
