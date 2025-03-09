import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Controller/filter_controller.dart';
import '../Controller/home_page_controller.dart';
import 'my_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  HomePageController controller = Get.put(HomePageController());
  FilterController filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
                  ),
                ),
                Text(
                  "T-Shirt",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Text('     ')
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                              width: 278,
                              height: 48,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFD0D4DD)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                controller: controller.searchController,
                                decoration: InputDecoration(
                                    hintText: 'Search T-Shirt...',
                                    hintStyle:
                                        TextStyle(color: Color(0xFFA6AEBE)),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Color(0xFFD0D4DD),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ))),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            // showDragHandle: T,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (context) {
                              return MyBottomSheet();
                            },
                          );
                        },
                        child: Obx(
                          () => Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                                color: filterController.isFiltered.value
                                    ? Color(0xFFF66743)
                                    : Colors.transparent,
                                border: Border.all(
                                    color: filterController.isFiltered.value
                                        ? Color(0xFFF66743)
                                        : Color(0xFFD0D4DD),
                                    width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.filter_alt_outlined,
                              color: filterController.isFiltered.value
                                  ? Colors.white
                                  : Color(0xFFD0D4DD),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${controller.products.length} Products found',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: GridView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: controller.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 250,
                        crossAxisSpacing: 15),
                    itemBuilder: (context, index) {
                      return _productContainer(index);
                    },
                  ),
                ))
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _productContainer(int index) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(controller.products[index].image),
                      scale: 3,
                      alignment: Alignment.bottomCenter)),
            ),
            Obx(
              () => Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () => controller.toggleFavorite(index),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(
                      controller.products[index].isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: controller.products[index].isFavorite
                          ? Colors.red
                          : Colors.grey,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.products[index].name,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  Text(
                    "\$${controller.products[index].price}",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFA6AEBE)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("\$${controller.products[index].discountPrice}",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF66743))),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
