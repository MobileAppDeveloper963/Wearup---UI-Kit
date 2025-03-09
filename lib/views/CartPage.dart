import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/CartController.dart';
import 'CartitemWidget.dart';
import 'ProductDetailpage.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final RxInt selectedIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                SizedBox(height: screenHeight * 0.05),
                const Text(
                  'Cart',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Obx(() {
                          bool isCheckboxSelected = cartController.cartItems
                              .every((item) => item["selected"] == true);

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isCheckboxSelected,
                                  activeColor: const Color(0xffF66743),
                                  checkColor: Colors.white,
                                  side: const BorderSide(
                                      color: Color(0xffD0D4DD), width: 1),
                                  onChanged: (value) {
                                    cartController
                                        .toggleAllSelection(selectedIndex);
                                  },
                                ),
                                const Text("Select all items",
                                    style: TextStyle(color: Colors.black)),
                                const Spacer(),
                                const Icon(
                                  Icons.delete_rounded,
                                  size: 23,
                                  color: Color(0xffD0D4DD),
                                )
                              ],
                            ),
                          );
                        }),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: cartController.cartItems.length,
                            itemBuilder: (context, index) {
                              var item = cartController.cartItems[index];
                              return GestureDetector(
                                onTap: () {
                                  selectedIndex.value =
                                      (selectedIndex.value == index)
                                          ? -1
                                          : index;
                                },
                                child: InkWell(
                                  onTap: () {
                                    Get.to(ProductDetailPage(
                                      name: item["name"] as String,
                                      size: item["size"] as String,
                                      price: item["price"] as int,
                                      quantity: item["quantity"] as int,
                                      imagePath: item["image"] as String,
                                      isSelected: item["selected"] as bool,
                                    ));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.05,
                                        vertical: screenHeight * 0.005),
                                    decoration: BoxDecoration(
                                      color: (item["selected"] as bool)
                                          ? const Color(0xffFFF9F7)
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: (item["selected"] as bool)
                                            ? const Color(0xffF66743)
                                            : Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: CartItemWidget(
                                      name: item["name"] as String,
                                      size: item["size"] as String,
                                      price: item["price"] as int,
                                      quantity: item["quantity"] as int,
                                      imagePath: item["image"] as String,
                                      isSelected: item["selected"] as bool,
                                      onIncrease: () => cartController
                                          .incrementQuantity(index),
                                      onDecrease: () => cartController
                                          .decrementQuantity(index),
                                      onSelect: (value) => cartController
                                          .toggleSelection(index, value),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              bool isAnyItemSelected = cartController.cartItems
                  .any((item) => item["selected"] == true);

              if (!isAnyItemSelected) return const SizedBox();

              int selectedCount = cartController.cartItems
                  .where((item) => item["selected"] == true)
                  .fold(0,
                      (sum, item) => sum + ((item["quantity"] as int?) ?? 1));

              double totalPrice = cartController.cartItems
                  .where((item) => item["selected"] == true)
                  .fold(0.0, (sum, item) {
                double price = (item["price"] as num?)?.toDouble() ?? 0.0;
                int quantity = (item["quantity"] as int?) ?? 1;
                return sum + (price * quantity);
              });

              return Positioned(
                bottom: screenHeight * 0.03,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: screenHeight * 0.01),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.005,
                            horizontal: screenWidth * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xffE2E4E9), width: 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.local_offer,
                                color: Color(0xffF66743)),
                            SizedBox(width: screenWidth * 0.02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Save more with promo",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12)),
                                Text("You have 5 promo available",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios,
                                size: 23, color: Color(0xffD0D4DD)),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Price ($selectedCount items)",
                              style: const TextStyle(fontSize: 16)),
                          Text("\$${totalPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Price",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\$${totalPrice.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffF66743),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: screenHeight * 0.07,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.red),
                          child: Center(
                            child: Text(
                                "Continue (\$${totalPrice.toStringAsFixed(2)})",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
