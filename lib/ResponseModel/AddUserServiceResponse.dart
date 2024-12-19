class AddUserServiceResponse {
  String? message;
  bool? error;
  List<AddUserServiceResponseData>? data;

  AddUserServiceResponse({this.message, this.error, this.data});

  AddUserServiceResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <AddUserServiceResponseData>[];
      json['data'].forEach((v) {
        data!.add(new AddUserServiceResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddUserServiceResponseData {
  int? userServiceId;
  String? id;
  String? entity;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  Null? receipt;
  Null? offerId;
  String? status;
  int? attempts;
  int? createdAt;

  AddUserServiceResponseData(
      {this.userServiceId,
        this.id,
        this.entity,
        this.amount,
        this.amountPaid,
        this.amountDue,
        this.currency,
        this.receipt,
        this.offerId,
        this.status,
        this.attempts,
        this.createdAt});

  AddUserServiceResponseData.fromJson(Map<String, dynamic> json) {
    userServiceId = json['userServiceId'];
    id = json['id'];
    entity = json['entity'];
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    amountDue = json['amount_due'];
    currency = json['currency'];
    receipt = json['receipt'];
    offerId = json['offer_id'];
    status = json['status'];
    attempts = json['attempts'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userServiceId'] = this.userServiceId;
    data['id'] = this.id;
    data['entity'] = this.entity;
    data['amount'] = this.amount;
    data['amount_paid'] = this.amountPaid;
    data['amount_due'] = this.amountDue;
    data['currency'] = this.currency;
    data['receipt'] = this.receipt;
    data['offer_id'] = this.offerId;
    data['status'] = this.status;
    data['attempts'] = this.attempts;
    data['created_at'] = this.createdAt;
    return data;
  }
}