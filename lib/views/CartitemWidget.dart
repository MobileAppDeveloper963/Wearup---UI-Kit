import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/CartController.dart';

class CartItemWidget extends StatelessWidget {
  final String name, size, imagePath;
  final int price, quantity;
  final bool isSelected;
  final VoidCallback onIncrease, onDecrease;
  final Function(bool) onSelect;

  const CartItemWidget({
    Key? key,
    required this.name,
    required this.size,
    required this.price,
    required this.quantity,
    required this.imagePath,
    required this.isSelected,
    required this.onIncrease,
    required this.onDecrease,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              bool newValue = !isSelected;
              onSelect(newValue);
              int index = Get.find<CartController>()
                  .cartItems
                  .indexWhere((item) => item["name"] == name);
              if (index != -1) {
                Get.find<CartController>().updateCheckboxState(index, newValue);
              }
            },
            child: SizedBox(
              width: 15,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    if (value != null) {
                      onSelect(value);
                      int index = Get.find<CartController>()
                          .cartItems
                          .indexWhere((item) => item["name"] == name);
                      if (index != -1) {
                        Get.find<CartController>()
                            .updateCheckboxState(index, value);
                      }
                    }
                  },
                  activeColor: const Color(0xffF66743),
                  checkColor: Colors.white,
                  side: const BorderSide(color: Color(0xffF66743), width: 1),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: screenHeight * 0.1,
            width: screenWidth * 0.2,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // Responsive font size
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  size,
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Text(
                      "\$$price.00",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffF66743),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onDecrease,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(39),
                          border: Border.all(
                            color: quantity > 0 ? Colors.red : Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: screenWidth * 0.025, // Responsive radius
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.remove,
                            color: quantity > 0 ? Colors.red : Colors.grey,
                            size: screenWidth * 0.03,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "$quantity",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onIncrease,
                      child: CircleAvatar(
                        radius: screenWidth * 0.03,
                        backgroundColor: const Color(0xffF66743),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
