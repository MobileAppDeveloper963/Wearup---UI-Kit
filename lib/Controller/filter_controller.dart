import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FilterController extends GetxController {
  var priceRange = RangeValues(18, 90).obs;
  var selectedColor = 2.obs;
  var selectedSize = "L".obs;
  RxBool isFiltered = false.obs;

  List<Color> colorList = [
    Color(0xFFF5D7CF),
    Color(0xFF95A6CF),
    Color(0xFFD6CFC9),
    Color(0xFFC6C6CE),
    Color(0xFFCCAD9E),
  ];

  List sizeList = [
    'S',
    'M',
    'L',
    'XL',
  ];
  void updatePriceRange(RangeValues values) {
    priceRange.value = values;
  }

  void updateColor(int index) {
    selectedColor.value = index;
  }

  void updateSize(String size) {
    selectedSize.value = size;
  }

  void defaultFilter() {
    priceRange.value = RangeValues(0, 200);
    selectedColor.value = -1;
    selectedSize.value = "X";
    isFiltered.value = false;
  }

  void updateFilter(bool value) {
    isFiltered.value = value;
  }
}
