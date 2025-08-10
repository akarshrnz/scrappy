import 'package:flutter/material.dart';
import 'package:scrappy/core/utils/color_const.dart';
import 'package:scrappy/core/utils/image_constant.dart';
import 'package:scrappy/model/ProductResponse.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final String imageUrl = 'assets/product.png';

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Product image section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Image.network(
              imageUrl,
              height: MediaQuery.of(context).size.height * 0.55,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                ImageConstant.imageNotFound,
                height: MediaQuery.of(context).size.height * 0.55,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Back button
          Positioned(
            top: 40,
            left: 16,
            child: Align(
    alignment: Alignment.topLeft,
    child: CircleAvatar(
      radius: 15,
      backgroundColor: Colors.white,
      child: Center( // Force perfect centering
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 14),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    ),
  ),
          ),

          // Heart icon
          Positioned(
            top: 40,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          ),

          // Bottom details
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                   product.prodName??"",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Two containers of 120L and 2 Kg Inoculum powder",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Product description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text(
                          "₹7,100",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 16),
                         Text(
                          "₹${product.rate}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0XFFFFF0E3),
                          radius: 26,
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 80),
                        Expanded(
                          child: GestureDetector(
                                onTap: () async {
                                
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
                                      "Buy Now",
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
