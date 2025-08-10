import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scrappy/controller/provider/homeProvider.dart';
import 'package:scrappy/core/utils/color_const.dart';
import 'package:scrappy/core/utils/globalConst.dart';
import 'package:scrappy/core/utils/image_constant.dart';
import 'package:scrappy/views/widgets/DotLoadingIndicator.dart';

class CleaningScreen
    extends
        StatefulWidget {
  const CleaningScreen({
    Key? key,
  }) : super(
         key: key,
       );

  @override
  CleaningScreenState createState() => CleaningScreenState();
}

class CleaningScreenState
    extends
        State<
          CleaningScreen
        > {
  final _scaffoldKey =
      GlobalKey<
        ScaffoldState
      >();

  late HomeProvider provider;
  @override
  void initState() {
    super.initState();

    provider =
        Provider.of<
          HomeProvider
        >(
          context,
          listen: false,
        );

    WidgetsBinding.instance.addPostFrameCallback(
      (
        timeStamp,
      ) {
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    print(
      "build",
    );
    return Scaffold(
     
      key: _scaffoldKey,
      body:
          Consumer<
            HomeProvider
          >(
            builder:
                (
                  context,
                  homeListenableProvider,
                  _,
                ) {
                  return  SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(
                              context,
                            ).size.height,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorConst.appColor,
                                  ColorConst.appColor,
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 50,),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  color: const Color(
                                    0xFFD32F2F,
                                  ), // Red background
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Scrappy Logo
                                      Image.asset(
                                        ImageConstant.logoTransparent, // Replace with your logo asset
                                        height: 40,
                                      ),
                                      // Cart Icon
                                      const Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: const Color(
                                    0xFFD32F2F,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      // Amber "=" Button
                                      Container(
                                        height: 38,
                                        width: 38,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Icon(
                                      Icons.sort,
                                          color: Colors.black,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
    
                                      // Search Bar
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: const TextField(
                                            decoration: InputDecoration(
                                              hintText: "Search here...",
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                              ),
                                              isDense: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                 const SizedBox(
                                        height: 20,
                                      ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                          60,
                                        ),
                                        topRight: Radius.circular(
                                          60,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                       
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                },
          ),
    );
  }

 

 
}
