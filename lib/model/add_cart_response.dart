class AddCartResponse {
//  Data? data;
  String? message;
  String? statusCode;

  AddCartResponse({ this.message, this.statusCode});

  AddCartResponse.fromJson(Map<String, dynamic> json) {
   // data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.data != null) {
    //   data['data'] = this.data!.toJson();
    // }
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Data {
  num? userId;
  num? prodId;
  num? noOfItems;
  String? updatedAt;
  String? createdAt;
  num? id;

  Data(
      {this.userId,
      this.prodId,
      this.noOfItems,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    prodId = json['prod_id'];
    noOfItems = json['no_of_items'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['prod_id'] = this.prodId;
    data['no_of_items'] = this.noOfItems;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
