import 'package:flutter/material.dart';
import 'package:scrappy/controller/service/home_service.dart';
import 'package:scrappy/core/utils/app_const.dart';
import 'package:scrappy/model/ProductResponse.dart';
import 'package:scrappy/model/category_response.dart';
import 'package:scrappy/model/home_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider
    with
        ChangeNotifier {
  bool homeLoading = false;
  bool cartLoading = false;

  List<
    HomeData
  >
  homeList = [];
  List<
    Category
  >
  categoryList = [];
  List<
    Product
  >
  productList = [];
  List<
    Product
  >
  cartProductList = [];
  String? userId;

Future<void>  getUser() async {
     if (userId ==
        null) {
SharedPreferences pref = await SharedPreferences.getInstance();
    userId = await pref.getString(
      'userId',
    );    }

    print("user id is ${userId}");
    
  }

  void init({
    bool? showShop,
  }) async {
    if(homeList.isEmpty){
       homeLoading = true;
    notifyListeners();

    }
   
    getUser();

    await getHome();
    getCart();

    if (showShop ==
        true) {
    } else {
      await getCategories();
    }

    homeLoading = false;
    notifyListeners();
  }

  /// Fetch Home Data
  Future<
    void
  >
  getHome() async {


    final result = await HomeService.getHome();

    if (result.error ==
            null &&
        result.data !=
            null) {
      if (result.data!.statusCode ==
          "200") {
        homeList
          ..clear()
          ..addAll(
            result.data!.data ??
                [],
          );
        if ((result.data!.data ??
                [])
            .isNotEmpty) {
          productList
            ..clear()
            ..addAll(
              result.data!.data![0].product ??
                  [],
            );
        }
      } else {
        // AppConst.toastMsg(
        //   msg: result.data!.message ?? "Something went wrong",
        //   backgroundColor: Colors.red,
        // );
      }
    } else {
      // AppConst.toastMsg(
      //   msg: result.error ?? "Something went wrong",
      //   backgroundColor: Colors.red,
      // );
    }

    notifyListeners();
  }

  /// Fetch Home Data
  Future<
    void
  >
  getCart({bool? showLoading}) async {
    if(showLoading==false){

    }else{
       cartLoading = true;
    notifyListeners();

    }
   
       await getUser();

    final result = await HomeService.getCart(userId: userId.toString());

    if (result.error ==
            null &&
        result.data !=
            null) {
      if (result.data!.statusCode ==
          "200") {
        if ((result.data!.data).isNotEmpty) {
          cartProductList
            ..clear()
            ..addAll(
              result.data!.data[0],
            );
        }
      } else {
        cartProductList = [];
      }
    } else {
      cartProductList = [];
    }
    cartLoading = false;

    notifyListeners();
  }

  Future<
    void
  >
  addProductToCart({
    required Product prod,
    required int noOfItems,
  }) async {
    final result = await HomeService.addCart(
      body: {
        "user_id": userId,
        "prod_id":
            prod.id ??
            prod.prodIdCart,
        "no_of_items": noOfItems,
      },
    );

    if (result.error ==
            null &&
       
        result.data!.statusCode ==
            "200") {
      getCart(showLoading: false);
      AppConst.toastMsg(
        msg: " Product added to cart",
        backgroundColor: Colors.green,
      );
    } else {
      AppConst.toastMsg(
        msg:
            result.error ??
            "Something went wrong",
        backgroundColor: Colors.red,
      );
      ;
    }
  }

  Future<
    void
  >
  deleteCartItem({
    required int cartID,
  }) async {
    final result = await HomeService.deleteCartItem(
     cartID,
    );
 

    if (result.error ==
            null &&
       
        result.data!.statusCode ==
            "200") {
      getCart(showLoading: false);
      AppConst.toastMsg(
        msg: "Success",
          
        backgroundColor: Colors.green,
      );
    } else {
      AppConst.toastMsg(
        msg:
            result.error ??
            "Something went wrong",
        backgroundColor: Colors.red,
      );
      ;
    }
  }

  bool checkItemInCart(
    int id,
  ) {
    return cartProductList.any(
      (
        element,
      ) =>
          element.prodIdCart ==
          id,
    );
  }
  // /// Fetch Home Data
  // Future<
  //   void
  // >
  // getProduct() async {
  //   final result = await HomeService.getProduct();

  //   if (result.error ==
  //           null &&
  //       result.data !=
  //           null) {
  //     if (result.data!.statusCode ==
  //         "200") {
  //       product
  //         ..clear()
  //         ..addAll(
  //           result.data!.data ??
  //               [],
  //         );
  //     } else {
  //       // AppConst.toastMsg(
  //       //   msg: result.data!.message ?? "Something went wrong",
  //       //   backgroundColor: Colors.red,
  //       // );
  //     }
  //   } else {
  //     // AppConst.toastMsg(
  //     //   msg: result.error ?? "Something went wrong",
  //     //   backgroundColor: Colors.red,
  //     // );
  //   }

  //   notifyListeners();
  // }

  /// Fetch Category Data
  Future<
    void
  >
  getCategories() async {
    final result = await HomeService.getCategory();

    if (result.error ==
            null &&
        result.data !=
            null) {
      if (result.data!.statusCode ==
          "200") {
        categoryList
          ..clear()
          ..addAll(
            result.data!.data ??
                [],
          );
      } else {
        // AppConst.toastMsg(
        //   msg: result.data!.message ?? "Something went wrong",
        //   backgroundColor: Colors.red,
        // );
      }
    } else {
      // AppConst.toastMsg(
      //   msg: result.error ?? "Something went wrong",
      //   backgroundColor: Colors.red,
      // );
    }
    notifyListeners();
  }
}
