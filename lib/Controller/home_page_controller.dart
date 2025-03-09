import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product_model.dart';

class HomePageController extends GetxController {
  TextEditingController searchController = TextEditingController();
  var products = <ProductModel>[
    ProductModel(
      name: "Bombboogie T-Shirt",
      image: "Assets/images/image 8.png",
      price: 470.00,
      discountPrice: 317.00,
    ),
    ProductModel(
        name: "Ocean Pacific T-Shirt",
        image: "Assets/images/image 58.png",
        price: 348.00,
        discountPrice: 258.00,
        isFavorite: true),
    ProductModel(
        name: "Giordano T-Shirt",
        image: "Assets/images/image 56.png",
        price: 348.00,
        discountPrice: 258.00,
        isFavorite: true),
    ProductModel(
      name: "Tolliver T-Shirt",
      image: "Assets/images/image 36.png",
      price: 470.00,
      discountPrice: 317.00,
    ),
    ProductModel(
        name: "Ocean Pacific T-Shirt",
        image: "Assets/images/image 58.png",
        price: 348.00,
        discountPrice: 258.00,
        isFavorite: true),
    ProductModel(
      name: "Bombboogie T-Shirt",
      image: "Assets/images/image 8.png",
      price: 470.00,
      discountPrice: 317.00,
    ),
  ].obs;

  void toggleFavorite(int index) {
    products[index].isFavorite = !products[index].isFavorite;
    products.refresh();
  }
}
