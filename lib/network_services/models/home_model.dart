class HomeModel {
  bool? status;
  String? message;
  HomeData? data;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
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

class HomeData {
  int? userId;
  String? name;
  String? xbtBalance;
  String? xcoinBalance;
  String? usdtBalance;
  String? refferalCode;
  String? referredBy;
  String? status;
  String? mobileNo;
  String? email;

  HomeData(
      {this.userId,
        this.name,
        this.xbtBalance,
        this.xcoinBalance,
        this.usdtBalance,
        this.refferalCode,
        this.referredBy,
        this.status,
        this.mobileNo,
        this.email});

  HomeData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    xbtBalance = json['xbt_balance'];
    xcoinBalance = json['xcoin_balance'];
    usdtBalance = json['usdt_balance'];
    refferalCode = json['refferal_code'];
    referredBy = json['referred_by'].toString();
    status = json['status'];
    mobileNo = json['mobile_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['xbt_balance'] = xbtBalance;
    data['xcoin_balance'] = xcoinBalance;
    data['usdt_balance'] = usdtBalance;
    data['refferal_code'] = refferalCode;
    data['referred_by'] = referredBy;
    data['status'] = status;
    data['mobile_no'] = mobileNo;
    data['email'] = email;
    return data;
  }
}
