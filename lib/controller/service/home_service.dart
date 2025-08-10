import 'package:scrappy/core/utils/api_service.dart';
import 'package:scrappy/core/utils/appUrls.dart';
import 'package:scrappy/model/ProductResponse.dart';
import 'package:scrappy/model/add_cart_response.dart';
import 'package:scrappy/model/category_response.dart';
import 'package:scrappy/model/home_response.dart';

class HomeService {
  static Future<ApiResult<HomeResponse>> getHome() {
    return ApiService.request<HomeResponse>(
      url: AppApi.home,
      method: RequestMethod.get,
      parser: (data) => HomeResponse.fromJson(data),
    );
  }
  static Future<ApiResult<ProductResponse>> getProduct() {
    return ApiService.request<ProductResponse>(
      url: AppApi.product,
      method: RequestMethod.get,
      parser: (data) => ProductResponse.fromJson(data),
    );
  }
  static Future<ApiResult<ProductResponse>> getCart({required String userId}) {
    return ApiService.request<ProductResponse>(
      url: "${AppApi.cart}/$userId",
      method: RequestMethod.get,
      parser: (data) => ProductResponse.fromJson(data),
    );
  }
  static Future<ApiResult<AddCartResponse>> addCart({required Map<String, dynamic> body}) {
    return ApiService.request<AddCartResponse>(
      url: AppApi.cart,
      method: RequestMethod.post,
      body: body,
      parser: (data) => AddCartResponse.fromJson(data),
    );
  }

   static Future<ApiResult<AddCartResponse>> deleteCartItem(int id) {
    return ApiService.request<AddCartResponse>(
      url: "${AppApi.cart}/$id",
      method: RequestMethod.delete,
      parser: (data) => AddCartResponse.fromJson(data),
    );
  }

  static Future<ApiResult<CategoryResponse>> getCategory() {
    return ApiService.request<CategoryResponse>(
      url: AppApi.category,
      method: RequestMethod.get,
      parser: (data) => CategoryResponse.fromJson(data),
    );
  }
}
