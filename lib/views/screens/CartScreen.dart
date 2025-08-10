import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrappy/controller/provider/homeProvider.dart';
import 'package:scrappy/core/utils/color_const.dart';
import 'package:scrappy/views/screens/ProductCard.dart';
import 'package:scrappy/views/widgets/DotLoadingIndicator.dart';

class Cartscreen
    extends
        StatefulWidget {

  const Cartscreen({
    super.key,
  });

  @override
  State<
    Cartscreen
  >
  createState() => _CartscreenState();
}

class _CartscreenState
    extends
        State<
          Cartscreen
        > {
  late HomeProvider provider;
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

    WidgetsBinding.instance.addPostFrameCallback(
      (
        timeStamp,
      ) {
        provider.getCart();
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorConst.appPrimaryColor,
              ColorConst.appSecondaryColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: bodySection(
            context,
          ),
        ),
      ),
    );
  }

  Widget bodySection(
    BuildContext context,
  ) {
    return Consumer<
      HomeProvider
    >(
      builder:
          (
            context,
            homeListenableProvider,
            _,
          ) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 60,
                    bottom: 45,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () => Navigator.pop(
                          context,
                        ),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 14,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 25,
                  ),
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
                  child: homeListenableProvider.cartLoading
                      ? Center(
                          child: DotLoadingIndicator(
                            height:
                                MediaQuery.of(
                                  context,
                                ).size.height /
                                1.5,
                            indicatorColor: ColorConst.appColor,
                          ),
                        )
                      : homeListenableProvider.cartProductList.isEmpty?SizedBox(
                          height:
                                MediaQuery.of(
                                  context,
                                ).size.height /
                                1.5,
                        child: Center(child: Text("Your cart is empty!"))):
                       Column(
                        children: [
                          GridView.builder(
                            padding: EdgeInsets.only(top: 20),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                          
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.8,
                              ),
                              itemCount: homeListenableProvider.cartProductList.length,
                              itemBuilder:
                                  (
                                    context,
                                    index,
                                  ) {
                                    final product = homeListenableProvider.cartProductList[index];
                          
                                    return ProductCard(
                                      fromCart: true,
                                      product: product,
                                      isInCart: provider.checkItemInCart(
                                      
                                            product.prodIdCart??0
                                            ,
                                            
                                      ),
                                    );
                                  },
                            ),
                        ],
                      ),
                ),
              ],
            );
          },
    );
  }
}
