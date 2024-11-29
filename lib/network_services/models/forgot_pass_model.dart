class ForgotPassModel {
  bool? status;
  String? message;
  Data? data;

  ForgotPassModel({this.status, this.message, this.data});

  ForgotPassModel.fromJson(Map<String, dynamic> json) {
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
  String? mobileNo;
  int? userId;

  Data({this.mobileNo, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobile_no'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile_no'] = mobileNo;
    data['user_id'] = userId;
    return data;
  }
}
