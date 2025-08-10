class AuthResponse {
  List<Data>? data;
  String? message;
  String? statusCode;

  AuthResponse({this.data, this.message, this.statusCode});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Data {
  UserDetails? userDetails;
  String? authToken;

  Data({this.userDetails, this.authToken});

  Data.fromJson(Map<String, dynamic> json) {
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
    authToken = json['auth_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    data['auth_token'] = this.authToken;
    return data;
  }
}

class UserDetails {
  num? id;
  String? name;
  String? email;
  String? mobile;
  String? mobileOtp;
  String? status;
  // num? roleId;
  String? darkMode;
  String? createdAt;
  String? updatedAt;

  UserDetails(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.mobileOtp,
      this.status,
     // this.roleId,
      this.darkMode,
      this.createdAt,
      this.updatedAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    mobileOtp = json['mobile_otp'];
    status = json['status'];
    //roleId = json['role_id'];
    darkMode = json['dark_mode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['mobile_otp'] = this.mobileOtp;
    data['status'] = this.status;
    //data['role_id'] = this.roleId;
    data['dark_mode'] = this.darkMode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



// class RegisterResponse {
//   final List<UserData>? data;
//   final String? message;
//   final String? statusCode;

//   RegisterResponse({
//     this.data,
//     this.message,
//     this.statusCode,
//   });

//   factory RegisterResponse.fromJson(Map<String, dynamic> json) {
//     return RegisterResponse(
//       data: (json['data'] as List?)?.map((x) => UserData.fromJson(x)).toList(),
//       message: json['message'],
//       statusCode: json['status_code'],
//     );
//   }
// }

// class UserData {
//   final UserDetails? userDetails;

//   UserData({this.userDetails});

//   factory UserData.fromJson(Map<String, dynamic> json) {
//     return UserData(
//       userDetails: json['user_details'] != null
//           ? UserDetails.fromJson(json['user_details'])
//           : null,
//     );
//   }
// }

// class UserDetails {
//   final String? name;
//   final String? email;
//   final String? mobile;
//   final String? status;
//   final String? roleId;
//   final String? updatedAt;
//   final String? createdAt;
//   final num? id;

//   UserDetails({
//     this.name,
//     this.email,
//     this.mobile,
//     this.status,
//     this.roleId,
//     this.updatedAt,
//     this.createdAt,
//     this.id,
//   });

//   factory UserDetails.fromJson(Map<String, dynamic> json) {
//     return UserDetails(
//       name: json['name'],
//       email: json['email'],
//       mobile: json['mobile'],
//       status: json['status'],
//       roleId: json['role_id'],
//       updatedAt: json['updated_at'],
//       createdAt: json['created_at'],
//       id: json['id'],
//     );
//   }
// }
