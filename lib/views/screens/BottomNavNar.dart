import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:scrappy/core/utils/color_const.dart';
import 'package:scrappy/core/utils/image_constant.dart';
import 'package:scrappy/views/screens/CleaningScreen.dart';
import 'package:scrappy/views/screens/DigestScreen.dart';
import 'package:scrappy/views/screens/HomeScreen.dart';
import 'package:scrappy/views/screens/TaxiScreen.dart';
import 'package:scrappy/views/screens/drawer_section.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _pageController = PageController(initialPage: 2);
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 2);

  int maxCount = 5;

  late final List<Widget> _pages = [
    const TaxiScreen(),
    const CleaningScreen(),
    const HomeScreen(),
    const HomeScreen(showShop: true),
    const DigestScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      extendBody: true,
      bottomNavigationBar: (_pages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: ColorConst.gradientOne,
              notchColor: Colors.white,
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: true,
              durationInMilliSeconds: 300,
              itemLabelStyle:
                  const TextStyle(fontSize: 10, color: Colors.white),
              elevation: 1,
              kIconSize: 26.0,
              bottomBarItems: [
                // Taxi
                BottomBarItem(
                  inActiveItem: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.local_taxi, color: Colors.black,size: 17,)),
                  activeItem:
                      const Icon(Icons.local_taxi, color: Colors.black),
                  itemLabel: 'Taxi',
                ),
                // Cleaning
                BottomBarItem(
                  inActiveItem: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.cleaning_services, color: Colors.black,size: 17,)),
                  activeItem: const Icon(Icons.cleaning_services,
                      color: Colors.black),
                  itemLabel: 'Cleaning',
                ),
                // Scrap
                BottomBarItem(
                  inActiveItem: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child:
                          Icon(Icons.recycling_rounded, color: Colors.black,size: 17,)),
                  activeItem:
                      const Icon(Icons.recycling_rounded, color: Colors.black),
                  itemLabel: 'Scrap',
                ),
                // Shop
                BottomBarItem(
                  inActiveItem: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.shopping_bag_outlined,size: 17,
                          color: Colors.black)),
                  activeItem: const Icon(Icons.shopping_bag_outlined,
                      color: Colors.black),
                  itemLabel: 'Shop',
                ),
                // Digester
                //                 BottomBarItem(
                //   inActiveItem:  CircleAvatar(
                //     backgroundColor: Colors.white,child: Image.asset(ImageConstant.digester, color: Colors.black)),
                //   activeItem: Image.asset(ImageConstant.digester, color: Colors.black),
                //   itemLabel: 'Digester',
                // ),
                BottomBarItem(
                  inActiveItem: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.food_bank_rounded, color: Colors.black,size: 17,)),
                  activeItem:
                      const Icon(Icons.food_bank_rounded, color: Colors.black),
                  itemLabel: 'Digester',
                ),
              ],
              onTap: (index) {
                log('Selected index: $index');
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}
