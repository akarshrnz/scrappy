import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:scrappy/controller/provider/homeProvider.dart';
import 'package:scrappy/controller/provider/userProvider.dart';
import 'package:scrappy/core/utils/color_const.dart';
import 'package:scrappy/core/utils/image_constant.dart';
import 'package:scrappy/views/screens/CartScreen.dart';
import 'package:scrappy/views/widgets/DotLoadingIndicator.dart';

class DigestScreen
    extends
        StatefulWidget {
  final bool? showShop;
  const DigestScreen({
    Key? key,
    this.showShop,
  }) : super(
         key: key,
       );

  @override
  DigestScreenState createState() => DigestScreenState();
}

class DigestScreenState
    extends
        State<
          DigestScreen
        > {
  final _scaffoldKey =
      GlobalKey<
        ScaffoldState
      >();

  late HomeProvider provider;
  late UserProvider userProvider;
  final Set<
    num
  >
  selectedIndexes = {};
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
    userProvider =
        Provider.of<
          UserProvider
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
    return Container(
      // drawer: const CustomDrawer(),
      color: const Color(
        0xFFD32F2F,
      ),

      key: _scaffoldKey,
      child:
          Consumer<
            HomeProvider
          >(
            builder:
                (
                  context,
                  homeListenableProvider,
                  _,
                ) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          // Header
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorConst.appColor,
                                  ColorConst.appColor,
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  ImageConstant.logoTransparent,
                                  height: 40,
                                ),
                                GestureDetector(
                                  onTap: () {
                                     Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: Cartscreen(
            ),
          ),
        );
                                  },
                                  child: const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Search bar
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
                                GestureDetector(
                                  onTap: () {
                                    Scaffold.of(
                                      context,
                                    ).openDrawer();
                                  },
                                  child: Container(
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
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
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

                          // Rounded container that takes remaining height
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(
                                context,
                              ).size.width,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                color: ColorConst.screenBacgColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    60,
                                  ),
                                  topRight: Radius.circular(
                                    60,
                                  ),
                                ),
                              ),
                              child: homeListenableProvider.homeLoading
                                  ? Center(
                                      child: DotLoadingIndicator(
                                        indicatorColor: ColorConst.appColor,
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                      ),
                                      child: Column(
                                        children: [
                                         
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Stack(
                                            children: [
                                              Image.asset(ImageConstant.geoTagImag),
                                              Positioned(
                                                //top: 0,
                                                bottom:50,
                                                left: 50,right: 50,
                                                
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("Geo Tagging",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                                                  ],
                                                ))
                                            ],
                                          ),
                                            const SizedBox(
                                            height: 20,
                                          ),
                                          Image.asset(ImageConstant.customerServiceImag),
                                          
                                          SizedBox(
                                            height: 110,
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),

                 ],
                  );
                },
          ),
    );
  }

}


