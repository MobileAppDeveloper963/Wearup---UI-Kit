import 'dart:core';

import 'package:get/get.dart';

class CartController extends GetxController {
  final RxInt selectedIndex = (-1).obs;

  var currentIndex = 0.obs;
  var isBottomBarVisible = true.obs; // Bottom bar visibility ko manage karega

  void changeTabIndex(int index) {
    currentIndex.value = index;
    isBottomBarVisible.value = false; // Jab tab select ho, bottom bar hide ho
  }

  void showBottomBar() {
    isBottomBarVisible.value = true; // Agar kabhi wapas dikhana ho to
  }

  var cartItems = [
    {
      "name": "Warmers Sweatshirt",
      "size": "Medium Size",
      "price": 317,
      "quantity": 0,
      "image": "Assets/images/p (1).png",
      "selected": false,
    },
    {
      "name": "Sweatshirt Arm Blue",
      "size": "Medium Size",
      "price": 269,
      "quantity": 0,
      "image": "Assets/images/p (2).png",
      "selected": false,
    },
    {
      "name": "Warmers Sweatshirt",
      "size": "Medium Size",
      "price": 317,
      "quantity": 0,
      "image": "Assets/images/p (3).png",
      "selected": false,
    },
    {
      "name": "Sweatshirt Arm Blue",
      "size": "Medium Size",
      "price": 428,
      "quantity": 0,
      "image": "Assets/images/p (4).png",
      "selected": false,
    },
    {
      "name": "Warmers Sweatshirt",
      "size": "Medium Size",
      "price": 247,
      "quantity": 0,
      "image": "Assets/images/p (1).png",
      "selected": false,
    },
    {
      "name": "Sweatshirt Arm Blue",
      "size": "Medium Size",
      "price": 381,
      "quantity": 0,
      "image": "Assets/images/p (2).png",
      "selected": false,
    },
    {
      "name": "Warmers Sweatshirt",
      "size": "Medium Size",
      "price": 377,
      "quantity": 0,
      "image": "Assets/images/p (1).png",
      "selected": false,
    },
    {
      "name": "Sweatshirt Arm Blue",
      "size": "Medium Size",
      "price": 329,
      "quantity": 0,
      "image": "Assets/images/p (4).png",
      "selected": false,
    },
  ].obs;
  List selectImage = [].obs;
  var selectedCount = 0.obs;
  RxBool isAnyItemSelected = false.obs;
  var isCheckboxSelected = false.obs;
  RxInt selectedItemsCount = 0.obs;

  RxList<bool> selectedItems = <bool>[].obs;

  // ✅ Check if any checkbox is selected
  // bool get isAnyItemSelected => selectedItems.contains(true);
  // ✅ Initialize checkbox list (should be called when cart loads)
  void initializeSelection(int length) {
    selectedItems.assignAll(List.generate(length, (index) => false));
  }

  void updateCheckboxState(int index, bool isSelected) {
    cartItems[index]["isSelected"];
    cartItems[index] = {...cartItems[index], "selected": isSelected};
    cartItems.refresh();

    isAnyItemSelected.value = cartItems.any((item) => item["selected"] == true);
    selectedItems[index] = isSelected;
    if (isSelected) {
      selectedItemsCount++;
    } else {
      selectedItemsCount!;
    }
    update();
  }

  void increment() {
    selectedCount.value++;
  }

  void decrement() {
    if (selectedCount.value > 0) {
      selectedCount.value--;
    }
  }

  void deselectAll() {
    for (var item in cartItems) {
      item["selected"] = false;
    }
    cartItems.refresh();
  }

  void toggleAllSelection(bool) {
    var allSelected = cartItems.every((item) => item["selected"] == true);
    cartItems.value =
        cartItems.map((item) => {...item, "selected": !allSelected}).toList();
    cartItems.refresh();
  }

  void incrementQuantity(int index) {
    cartItems[index] = {
      ...cartItems[index],
      "quantity": (cartItems[index]["quantity"] as int) + 1
    };
    cartItems.refresh();
  }

  void decrementQuantity(int index) {
    if ((cartItems[index]["quantity"] as int) > 0) {
      cartItems[index] = {
        ...cartItems[index],
        "quantity": (cartItems[index]["quantity"] as int) - 1
      };
      cartItems.refresh();
    }
  }

  // Check if any checkbox is selected
  bool get isAnyCheckboxSelected =>
      cartItems.any((item) => item["isSelected"] == true);

  // void updateCheckboxState(int index, bool value) {
  // cartItems[index]["isSelected"] = value;
  // update(); // Refresh UI
  // }

  void toggleSelection(int index, bool? value) {
    cartItems[index] = {...cartItems[index], "selected": value ?? false};
    cartItems.refresh();
  }

  double get totalPrice =>
      cartItems.where((item) => item["selected"] == true).fold(
          0.0,
          (sum, item) =>
              sum + (item["price"] as int) * (item["quantity"] as int));
}
