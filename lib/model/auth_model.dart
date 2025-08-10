class RegisterRequest {
  final String? name;
  final String? email;
  final String? password;
  final String? mobile;

  RegisterRequest({ this.name,  this.email,  this.password,  this.mobile});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'mobile': mobile,
      };
}
