import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:scrappy/controller/provider/homeProvider.dart';
import 'package:scrappy/controller/provider/userProvider.dart';
import 'package:scrappy/core/utils/color_const.dart';
import 'package:scrappy/core/utils/globalConst.dart';
import 'package:scrappy/core/utils/image_constant.dart';
import 'package:scrappy/model/ProductResponse.dart';
import 'package:scrappy/views/screens/CartScreen.dart';
import 'package:scrappy/views/screens/FormSubmit.dart';
import 'package:scrappy/views/screens/ProductCard.dart';
import 'package:scrappy/views/screens/ProductDetailsScreen.dart';
import 'package:scrappy/views/screens/drawer_section.dart';
import 'package:scrappy/views/widgets/DotLoadingIndicator.dart';

class HomeScreen
    extends
        StatefulWidget {
  final bool? showShop;
  const HomeScreen({
    Key? key,
    this.showShop,
  }) : super(
         key: key,
       );

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState
    extends
        State<
          HomeScreen
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
        provider.init(
          showShop: widget.showShop,
        );
        userProvider.loadUserData();
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
                                        child: Cartscreen(),
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
                                          bannerWidget(
                                            homeListenableProvider,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          (homeListenableProvider.categoryList.isNotEmpty &&
                                                  widget.showShop !=
                                                      true)
                                              ? categorySection(
                                                  homeListenableProvider,
                                                )
                                              : SizedBox(),
                                          (widget.showShop ==
                                                  true)
                                              ? productSection(
                                                  homeListenableProvider,
                                                )
                                              : SizedBox(),
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

                      Positioned(
                        bottom: 110,
                        left: 20,
                        right: 20,
                        child: selectedIndexes.isEmpty
                            ? SizedBox()
                            : GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FormScreen(
                                        subCatIds: selectedIndexes.toList(),
                                      ),
                                    ),
                                  );
                                  selectedIndexes.clear();
                                  setState(
                                    () {},
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(
                                    context,
                                  ).size.width,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      25,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorConst.appSecondaryColor,
                                        ColorConst.appPrimaryColor,
                                      ],
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  );
                },
          ),
    );
  }

  GridView productSection(
    HomeProvider homeListenableProvider,
  ) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: homeListenableProvider.productList.length,
      itemBuilder:
          (
            context,
            index,
          ) {
            final product = homeListenableProvider.productList[index];

            return ProductCard(
              fromCart: false,
              product: product,
              isInCart: provider.checkItemInCart(
                product.id ??
                    product.cartId ??
                    0,
              ),
            );
          },
    );
  }

  GridView categorySection(
    HomeProvider homeListenableProvider,
  ) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio:
            2 /
            1.6,
      ),
      itemCount: homeListenableProvider.categoryList.length,
      itemBuilder:
          (
            context,
            index,
          ) {
            final item = homeListenableProvider.categoryList[index];
            final isSelected = selectedIndexes.contains(
              item.id,
            );
            return GestureDetector(
              onTap: () {
                setState(
                  () {
                    if (item.id !=
                        null) {
                      isSelected
                          ? selectedIndexes.remove(
                              item.id,
                            )
                          : selectedIndexes.add(
                              item.id ??
                                  0,
                            );
                    }
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [
                            ColorConst.appColor,
                            ColorConst.appSecondaryColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isSelected
                      ? null
                      : Colors.white,
                  boxShadow: isSelected
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                              0.3,
                            ),
                            blurRadius: 5,
                            offset: const Offset(
                              0,
                              3,
                            ),
                          ),
                        ],
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: Text(
                    item.subCategory ??
                        "",
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
    );
  }

  SizedBox bannerWidget(
    HomeProvider homeListenableProvider,
  ) {
    return homeListenableProvider.homeList.isEmpty ||
            homeListenableProvider.homeList[0].banner ==
                null
        ? SizedBox()
        : SizedBox(
            height: 327.h,
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: homeListenableProvider.homeList[0].banner!.length,
              itemBuilder:
                  (
                    context,
                    index,
                    realIndex,
                  ) {
                    final data = homeListenableProvider.homeList[0].banner![index];
                    return Image.network(
                      getImageUrl(
                        data.image ??
                            "",
                      ),
                      width: double.infinity,
                      fit: BoxFit.fill,
                      height: 327.h,
                      errorBuilder:
                          (
                            context,
                            error,
                            stackTrace,
                          ) => Image.asset(
                            ImageConstant.imageNotFound,
                          ),
                    );
                  },
              options: CarouselOptions(
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                viewportFraction: 1,
                height: 327.h,
                autoPlay: true,
                autoPlayInterval: const Duration(
                  seconds: 5,
                ),
                onPageChanged:
                    (
                      index,
                      reason,
                    ) {},
              ),
            ),
          );
  }

  // /// Section Widget
  // Widget auctionWidget(BuildContext context, List<AuctionModel> auctionList) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: 310,
  //     child: ListView.separated(
  //       padding: EdgeInsets.only(left: 12.w),
  //       scrollDirection: Axis.horizontal,
  //       physics: BouncingScrollPhysics(),
  //       separatorBuilder: (context, index) => SizedBox(
  //         width: 10.w,
  //       ),
  //       itemCount: auctionList.length,
  //       itemBuilder: (context, index) {
  //         final auctionModel = auctionList[index];
  //         return  FadeInRight(
  //           duration: Durations.extralong1,
  //           child: AuctionCardWidget(
  //             auctionModel: auctionModel,
  //           ),
  //         );

  //       },
  //     ),
  //   );
  // }
}
