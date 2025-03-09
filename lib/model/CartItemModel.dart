class CartItemModel {
  String name;
  String size;
  int price;
  int quantity;
  String imagePath;
  bool isSelected;

  CartItemModel({
    required this.name,
    required this.size,
    required this.price,
    required this.quantity,
    required this.imagePath,
    this.isSelected = false,
  });

  void toggleSelection() {
    isSelected = !isSelected;
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
