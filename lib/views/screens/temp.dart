// import 'package:flutter/material.dart';
// import 'package:scrappy/core/utils/color_const.dart';

// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.white,
//       child: Column(
//         children: [
//           // Header
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [ColorConst.appSecondaryColor,ColorConst.appColor,],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(40),
//                 bottomRight: Radius.circular(40),
//               ),
//             ),
//             padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: CircleAvatar(
//                     radius: 17,
//                     backgroundColor: Colors.white,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black,size: 15,),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       const CircleAvatar(
//                         radius: 24,
//                         backgroundColor: Colors.white,
//                         child: Icon(Icons.person, color: Colors.black),
//                       ),
//                       const SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             "Sherlock Holmes",
//                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                           Text(
//                             "name@gmail.com",
//                             style: TextStyle(color: Colors.white70, fontSize: 14),
//                           ),
//                           Text(
//                             "+91 9999 555 666",
//                             style: TextStyle(color: Colors.white70, fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Menu Items
//           Expanded(
//             child: ListView(
//               children: [
//                 _drawerItem(Icons.person_outline, "Profile"),
//                 _drawerItem(Icons.shopping_bag_outlined, "My Orders"),
//                 _drawerItem(Icons.sell_outlined, "My Sellings"),
//                 _drawerItem(Icons.favorite_border, "Wishlist"),
//                 _drawerItem(Icons.local_shipping_outlined, "Track Order"),
//                 const Divider(),
//                 _drawerItem(Icons.info_outline, "About Us"),
//                 _drawerItem(Icons.assignment_return_outlined, "Return Policy"),
//                 _drawerItem(Icons.privacy_tip_outlined, "Privacy Policy"),
//                 const Divider(),
//                 const ListTile(
//                   title: Text(
//                     "Help and Support",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const ListTile(
//                   title: Text(
//                     "Terms and Conditions",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//             padding: const EdgeInsets.all(16),
//             child: InkWell(
//               onTap: () {},
//               child: Row(
//                 children: const [
//                   Icon(Icons.logout, color: Colors.red),
//                   SizedBox(width: 8),
//                   Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//           ),
//               ],
//             ),
//           ),

//           // Logout at bottom
          
//         ],
//       ),
//     );
//   }

//   Widget _drawerItem(IconData icon, String text) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.red),
//       title: Text(text),
//       onTap: () {},
//     );
//   }
// }



// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:scrappy/core/utils/color_const.dart';
// import 'package:scrappy/core/utils/image_constant.dart';
// import 'package:scrappy/views/screens/CleaningScreen.dart';
// import 'package:scrappy/views/screens/DigestScreen.dart';
// import 'package:scrappy/views/screens/HomeScreen.dart';
// import 'package:scrappy/views/screens/TaxiScreen.dart';
// import 'package:scrappy/views/screens/drawer_section.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   /// Controller for PageView
//   final _pageController = PageController(initialPage: 2);

//   /// Controller for Notch Bottom Bar
//   final NotchBottomBarController _controller = NotchBottomBarController(index: 2);

//   int maxCount = 5;

//   late final List<Widget> _pages = [
//     const TaxiScreen(),
//     const CleaningScreen(),
//     const HomeScreen(),
//         const HomeScreen(showShop: true,),

//     // const ShopScreen(),
//     const DigestScreen(),
//   ];

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//                drawer: const CustomDrawer(),

//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: _pages,
//       ),
//       extendBody: true,
//       bottomNavigationBar: (_pages.length <= maxCount)
//           ? AnimatedNotchBottomBar(
//               notchBottomBarController: _controller,
//               color: ColorConst.gradientOne,
//               notchColor: Colors.white, 
//               showLabel: true,
//               textOverflow: TextOverflow.visible,
//               maxLine: 1,
//               shadowElevation: 5,
//               kBottomRadius: 28.0,
//               removeMargins: false,
//               bottomBarWidth: 500,
//               showShadow: true,
//               durationInMilliSeconds: 300,
//               itemLabelStyle: const TextStyle(fontSize: 10, color: Colors.white),
//               elevation: 1,
//               kIconSize: 24.0,
//               bottomBarItems: [
//                 BottomBarItem(
//                   inActiveItem: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: Image.asset(ImageConstant.taxi, color: Colors.black)),
//                   activeItem: Image.asset(ImageConstant.taxi, color: Colors.black),
//                   itemLabel: 'Taxi',
//                 ),
//                 BottomBarItem(
//                   inActiveItem: CircleAvatar(
//                     backgroundColor: Colors.white,child: Image.asset(ImageConstant.cleaning, color: Colors.black)),
//                   activeItem: Image.asset(ImageConstant.cleaning, color: Colors.black),
//                   itemLabel: 'Cleaning',
//                 ),
//                 BottomBarItem(
//                   inActiveItem:  CircleAvatar(
//                     backgroundColor: Colors.white,child: Image.asset(ImageConstant.scrap, color: Colors.black)),
//                   activeItem: Image.asset(ImageConstant.scrap, color: Colors.black),
//                   itemLabel: 'Scrap',
//                 ),
//                 BottomBarItem(
//                   inActiveItem:  CircleAvatar(
//                     backgroundColor: Colors.white,child: Image.asset(ImageConstant.shop, color: Colors.black)),
//                   activeItem: Image.asset(ImageConstant.shop, color: Colors.black),
//                   itemLabel: 'Shop',
//                 ),
                // BottomBarItem(
                //   inActiveItem:  CircleAvatar(
                //     backgroundColor: Colors.white,child: Image.asset(ImageConstant.digester, color: Colors.black)),
                //   activeItem: Image.asset(ImageConstant.digester, color: Colors.black),
                //   itemLabel: 'Digester',
                // ),
//               ],
//               onTap: (index) {
//                 log('Selected index: $index');
//                 _pageController.jumpToPage(index);
//               },
//             )
//           : null,
//     );
//   }
// }
