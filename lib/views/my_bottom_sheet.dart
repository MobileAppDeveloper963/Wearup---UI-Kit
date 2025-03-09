import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Controller/filter_controller.dart';

class MyBottomSheet extends StatelessWidget {
  MyBottomSheet({super.key});
  final FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 497.h,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 70,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Price Range",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Obx(
              () => RangeSlider(
                values: controller.priceRange.value,
                min: 0,
                max: 200,
                divisions: 100,
                labels: RangeLabels(
                    "\$${controller.priceRange.value.start.toString()}",
                    "\$${controller.priceRange.value.end.toString()}"),
                activeColor: Color(0xFFF66743),
                inactiveColor: Colors.grey.shade300,
                onChanged: (values) {
                  controller.updatePriceRange(values);
                },
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "\$${controller.priceRange.value.start.toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${controller.priceRange.value.end.toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Colors",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.colorList.length,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Obx(
                          () => Stack(
                            children: [
                              GestureDetector(
                                onTap: () => controller.updateColor(index),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(
                                          width: 2,
                                          color:
                                              controller.selectedColor == index
                                                  ? controller.colorList[index]
                                                  : Colors.transparent)),
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 21,
                                      backgroundColor:
                                          controller.colorList[index],
                                      child: controller.selectedColor.value ==
                                              index
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 22,
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Size Item",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => controller
                                .updateSize(controller.sizeList[index]),
                            child: Obx(
                              () => Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                    color: controller.selectedSize.value ==
                                            controller.sizeList[index]
                                        ? Colors.orange.shade50
                                        : Colors.grey.shade100,
                                    border: Border.all(
                                        width: 2,
                                        color: controller.selectedSize.value ==
                                                controller.sizeList[index]
                                            ? Color(0xFFF66743)
                                            : Colors.grey),
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    controller.sizeList[index],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: controller.selectedSize.value ==
                                                controller.sizeList[index]
                                            ? Color(0xFFF66743)
                                            : Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              width: 17,
                            ),
                        itemCount: controller.sizeList.length),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: GestureDetector(
                      onTap: () {
                        controller.updateFilter(true);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFFF66743)),
                        child: Center(
                          child: Text(
                            'Show Result',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.defaultFilter();
                      Timer(Duration(milliseconds: 300), () {
                        controller.updateFilter(false);
                        Navigator.pop(context);
                      });
                    },
                    child: Center(
                      child: Text(
                        'Clear',
                        style: TextStyle(color: Color(0xFFF66743)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
