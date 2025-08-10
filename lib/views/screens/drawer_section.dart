import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:scrappy/controller/provider/userProvider.dart';
import 'package:scrappy/core/utils/color_const.dart';
import 'package:scrappy/views/screens/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          // Red Gradient Header
          Container(
            height: 280,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorConst.appSecondaryColor,
                  ColorConst.appColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            padding: const EdgeInsets.only(top: 45, left: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.black, size: 15),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, right: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProvider.name ?? "Guest User",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            userProvider.email ?? "noemail@example.com",
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                          Text(
                          "+91 " + (userProvider.mobile ?? ""),
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // White Card over Header
          Positioned(
            top: 220,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _drawerItem(Icons.person_outline, "Profile"),
                    _drawerItem(Icons.shopping_bag_outlined, "My Orders"),
                    _drawerItem(Icons.sell_outlined, "My Sellings"),
                    _drawerItem(Icons.favorite_border, "Wishlist"),
                    _drawerItem(
                        Icons.local_shipping_outlined, "Track Order"),
                    const Divider(
                        thickness: 0.8, color: ColorConst.appColor),
                    _drawerItem(Icons.info_outline, "About Us"),
                    _drawerItem(
                        Icons.assignment_return_outlined, "Return Policy"),
                    _drawerItem(
                        Icons.privacy_tip_outlined, "Privacy Policy"),
                    const Divider(
                        thickness: 0.8, color: ColorConst.appColor),
                    const SizedBox(height: 10),
                    const Text(
                      "Help and Support",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Terms and Conditions",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),

          // Logout Button
          Positioned(
            bottom: 20,
            left: 20,
            child: InkWell(
              onTap: () async {
                SharedPreferences pref =
                    await SharedPreferences.getInstance();
                await pref.clear();
                Provider.of<UserProvider>(context, listen: false)
                    .clearUserData();

                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: LoginScreen(),
                  ),
                );
              },
              child: Row(
                children: const [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String text) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: Colors.red),
      title: Text(text),
      onTap: () {},
    );
  }
}
