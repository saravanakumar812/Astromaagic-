class PaymentSuccessResponse {
  String? message;
  bool? error;

  PaymentSuccessResponse({this.message, this.error});

  PaymentSuccessResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}