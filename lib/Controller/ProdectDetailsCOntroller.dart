import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  var selectedSize = 0.obs;
  var selectedColor = 0.obs;
  var favorite = false.obs;
  var pageIndex = 0.obs;

  List<String> sizes = ['S', 'M', 'L', 'XL'];
  List<Color> colorList = [
    Color(0xFFF5D7CF),
    Color(0xFF95A6CF),
    Color(0xFFD6CFC9),
    Color(0xFFC6C6CE),
    Color(0xFFCCAD9E),
  ];
  final PageController pageController = PageController(viewportFraction: 0.8);

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void updateSize(int index) {
    selectedSize.value = index;
  }

  void updateColor(int index) {
    selectedColor.value = index;
  }

  void toggleFavorite() {
    favorite.value = !favorite.value;
  }
}
