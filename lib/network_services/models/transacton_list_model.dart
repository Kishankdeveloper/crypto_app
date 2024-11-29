class TransactionListModel {
  bool? status;
  String? message;
  List<TransactionData>? data;

  TransactionListModel({this.status, this.message, this.data});

  TransactionListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TransactionData>[];
      json['data'].forEach((v) {
        data!.add(TransactionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionData {
  int? id;
  String? transactionType;
  String? amount;
  String? transactionStatus;
  String? transactionDate;
  String? currency;
  String? creditDebitType;

  TransactionData(
      {this.id,
        this.transactionType,
        this.amount,
        this.transactionStatus,
        this.transactionDate,
        this.currency,
        this.creditDebitType});

  TransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionType = json['transaction_type'];
    amount = json['amount'];
    transactionStatus = json['transaction_status'];
    transactionDate = json['transaction_date'];
    currency = json['currency'];
    creditDebitType = json['credit_debit_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_type'] = transactionType;
    data['amount'] = amount;
    data['transaction_status'] = transactionStatus;
    data['transaction_date'] = transactionDate;
    data['currency'] = currency;
    data['credit_debit_type'] = creditDebitType;
    return data;
  }
}
