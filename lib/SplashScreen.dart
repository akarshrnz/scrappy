import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scrappy/core/utils/image_constant.dart';
import 'package:scrappy/views/screens/LoginScreen.dart';
import 'package:scrappy/views/screens/BottomNavNar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen
    extends
        StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState
    extends
        State<
          SplashScreen
        > {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(
        seconds: 3,
      ),
      () {
        checkLoginStatus();
      },
    );
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn =
        prefs.getBool(
          'isLoggedIn',
        ) ??
        false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: BottomNavBar(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: LoginScreen(),
        ),
      );

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginScreen()),
      // );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final size = MediaQuery.of(
      context,
    ).size;
    return Scaffold(
      // backgroundColor: ,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Image.asset(
          ImageConstant.splash,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
