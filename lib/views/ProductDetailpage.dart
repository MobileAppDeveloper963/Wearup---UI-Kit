import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/ProdectDetailsCOntroller.dart';
import 'home_page.dart';

class ProductDetailPage extends StatelessWidget {
  final String name;
  final String size;
  final int price;
  final int quantity;
  final String imagePath;

  ProductDetailPage({
    Key? key,
    required this.name,
    required this.size,
    required this.price,
    required this.quantity,
    required this.imagePath,
    required bool isSelected,
  }) : super(key: key);

  final ProductDetailController controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    List<String> displayImages = [
      imagePath,
      "Assets/images/p (1).png",
      "Assets/images/p (2).png",
      "Assets/images/p (3).png"
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                            controller: PageController(),
                            itemCount: displayImages.length,
                            physics: BouncingScrollPhysics(),
                            onPageChanged: (index) {
                              controller.pageIndex.value = index;
                            },
                            itemBuilder: (context, index) {
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage(displayImages[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 20,
                            child: Obx(() => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    displayImages.length,
                                    (index) => Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      width: controller.pageIndex.value == index
                                          ? 12
                                          : 8,
                                      height:
                                          controller.pageIndex.value == index
                                              ? 12
                                              : 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            controller.pageIndex.value == index
                                                ? Color(0xffF66743)
                                                : Colors.grey,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "\$${price}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffF66743),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit amet\n'
                            'luctus venenatis, lectus magna',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          SizedBox(height: 15),
                          Text('Size',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Row(
                            children:
                                List.generate(controller.sizes.length, (index) {
                              return Obx(
                                () => GestureDetector(
                                  onTap: () => controller.updateSize(index),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade200,
                                      border: Border.all(
                                        width: 2,
                                        color: controller.selectedSize.value ==
                                                index
                                            ? Color(0xffF66743)
                                            : Colors.grey,
                                      ),
                                    ),
                                    child: Text(
                                      controller.sizes[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: controller.selectedSize.value ==
                                                index
                                            ? Color(0xffF66743)
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 15),
                          Text('Color',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 60,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.colorList.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => GestureDetector(
                                    onTap: () => controller.updateColor(index),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2,
                                            color: controller
                                                        .selectedColor.value ==
                                                    index
                                                ? controller.colorList[index]
                                                : Colors.transparent),
                                      ),
                                      child: Center(
                                        child: CircleAvatar(
                                          radius: 21,
                                          backgroundColor:
                                              controller.colorList[index],
                                          child:
                                              controller.selectedColor.value ==
                                                      index
                                                  ? Icon(Icons.check,
                                                      color: Colors.white,
                                                      size: 22)
                                                  : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Color(0xffF66743),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () {
                              Get.to(HomePage());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: Obx(
                    () => GestureDetector(
                      onTap: () => controller.toggleFavorite(),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          controller.favorite.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller.favorite.value
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
