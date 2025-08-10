class ProductResponse {
    ProductResponse({
        required this.data,
        required this.message,
        required this.statusCode,
    });

    final List<List<Product>> data;
    final String? message;
    final String? statusCode;

    factory ProductResponse.fromJson(Map<String, dynamic> json){ 
        return ProductResponse(
            data: json["data"] == null ? [] : List<List<Product>>.from(json["data"]!.map((x) => x == null ? [] : List<Product>.from(x!.map((x) => Product.fromJson(x))))),
            message: json["message"],
            statusCode: json["status_code"],
        );
    }

    Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.map((x) => x.toJson()).toList()).toList(),
        "message": message,
        "status_code": statusCode,
    };

}

class Product {
    Product({
        required this.id,
        required this.prodName,
        required this.user,
        required this.image,
        required this.category,
        required this.subCategory,
        required this.preRate,
        required this.rate,
        required this.tax,
        required this.stock,
        required this.cOD,
        required this.status,
        this.cartId,
        this.cartQty,
        this.prodIdCart,
    });

    final int? id;
    final int? cartId;
    final String? cartQty;
    final int? prodIdCart;
    final String? prodName;
    final String? user;
    final String? image;
    final String? category;
    final String? subCategory;
    final String? preRate;
    final String? rate;
    final String? tax;
    final String? stock;
    final String? cOD;
    final String? status;

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            id: json["id"],
            cartQty: json["quantity"],
            cartId: json["cart_id"],
            prodIdCart: json["prod_id"],
            prodName: json["prod_name"],
            user: json["user"],
            image: json["image"],
            category: json["category"],
            subCategory: json["sub_category"],
            preRate: json["pre_rate"],
            rate: json["rate"],
            tax: json["tax"],
            stock: json["stock"],
            cOD: json["c_o_d"],
            status: json["status"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "prod_name": prodName,
        "user": user,
        "image": image,
        "category": category,
        "sub_category": subCategory,
        "pre_rate": preRate,
        "rate": rate,
        "tax": tax,
        "stock": stock,
        "c_o_d": cOD,
        "status": status,
    };

}
