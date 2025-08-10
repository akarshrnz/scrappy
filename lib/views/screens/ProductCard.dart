import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:scrappy/controller/provider/homeProvider.dart';
import 'package:scrappy/core/utils/image_constant.dart';
import 'package:scrappy/model/ProductResponse.dart';
import 'package:scrappy/views/screens/ProductDetailsScreen.dart';

class ProductCard
    extends
        StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.isInCart, required this.fromCart,
  });

  final Product product;
  final bool isInCart;
  final bool fromCart;

  @override
  Widget build(
    BuildContext context,
  ) {
    final provider =
        Provider.of<
          HomeProvider
        >(
          context,
          listen: false,
        );

    // print(
    //   "product in cart  ${isInCart} prod id ${product.id} cart id ${product.cartId}",
    // );
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: ProductDetailsScreen(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            16,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(
                0.15,
              ),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(
                0,
                2,
              ),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(
                      16,
                    ),
                  ),
                  child: Image.network(
                    product.image ??
                        "",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (
                          context,
                          error,
                          stackTrace,
                        ) => Image.asset(
                          ImageConstant.imageNotFound,
                        ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      if (isInCart && fromCart==true) {
                        provider.deleteCartItem(
                          cartID: product.cartId??0,
                        );
                      } else if(isInCart==false){
                        provider.addProductToCart(
                          prod: product,
                          noOfItems: 1,
                        );
                      }
                    },
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: isInCart
                          ? Colors.red
                          : Colors.white,
                      child: Icon(
                        Icons.favorite,
                        size: 16,
                        color: isInCart
                            ? Colors.white
                            : Colors.red,
                      ),
                      foregroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Text(
                product.prodName ??
                    "",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
