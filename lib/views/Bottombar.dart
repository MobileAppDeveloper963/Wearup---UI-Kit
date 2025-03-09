import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/CartController.dart';
import 'CartPage.dart';
import 'all_bottom_Screen.dart';
import 'home_page.dart';

class Bottombar extends StatelessWidget {
  Bottombar({super.key});

  final CartController bottomBarController = Get.put(CartController());

  final List<Widget> pages = [
    HomeScreen(),
    HomePage(),
    CartPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bottomBarHeight =
        screenWidth * 0.15; // Responsive height (15% of screen width)
    double bottomBarWidth =
        screenWidth * 0.85; // Responsive width (85% of screen width)

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            pages[bottomBarController.currentIndex.value],
            // if (bottomBarController.isBottomBarVisible.value)
            Positioned(
              bottom: 20,
              left: (screenWidth - bottomBarWidth) / 2,
              right: (screenWidth - bottomBarWidth) / 2,
              child: Container(
                height: bottomBarHeight,
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: const Offset(0, 10),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    selectedItemColor: Colors.red,
                    unselectedItemColor: const Color(0xffD0D4DD),
                    selectedFontSize: 12,
                    showSelectedLabels: true,
                    showUnselectedLabels: false,
                    currentIndex: bottomBarController.currentIndex.value,
                    onTap: (index) {
                      bottomBarController.changeTabIndex(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        icon: Icon(Icons.home_filled),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        icon: Icon(Icons.favorite_border),
                        label: 'Cart',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        icon: Icon(Icons.shopping_cart_outlined),
                        label: 'Favorites',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
