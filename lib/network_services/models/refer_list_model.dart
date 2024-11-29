class ReferListModel {
  bool? status;
  String? message;
  List<ReferList>? data;

  ReferListModel({this.status, this.message, this.data});

  ReferListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ReferList>[];
      json['data'].forEach((v) {
        data!.add(new ReferList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReferList {
  int? id;
  String? name;
  String? xcoinBalance;
  int? referredUsersCount;

  ReferList({this.id, this.name, this.xcoinBalance, this.referredUsersCount});

  ReferList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    xcoinBalance = json['xcoin_balance'];
    referredUsersCount = json['referred_users_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['xcoin_balance'] = this.xcoinBalance;
    data['referred_users_count'] = this.referredUsersCount;
    return data;
  }
}
