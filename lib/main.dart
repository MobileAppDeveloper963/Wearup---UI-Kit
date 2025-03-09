import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wearup_ui_kit/views/CartPage.dart';

import 'Controller/CartController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CartController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cart Page',
            theme: ThemeData.light(),
            home: CartPage(),
          );
        });
  }
}
