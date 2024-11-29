class LoginModel {
  bool? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? mobileNo;
  String? email;
  String? xbtBalance;
  String? xcoinBalance;

  Data(
      {this.id,
        this.name,
        this.mobileNo,
        this.email,
        this.xbtBalance,
        this.xcoinBalance});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    xbtBalance = json['xbt_balance'];
    xcoinBalance = json['xcoin_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile_no'] = mobileNo;
    data['email'] = email;
    data['xbt_balance'] = xbtBalance;
    data['xcoin_balance'] = xcoinBalance;
    return data;
  }
}
