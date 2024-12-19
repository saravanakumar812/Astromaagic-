class MobileNumberResponse {
  String? message;
  bool? error;
  int? otpNumber;

  MobileNumberResponse({this.message, this.error, this.otpNumber});

  MobileNumberResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    otpNumber = json['otpNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['otpNumber'] = this.otpNumber;
    return data;
  }
}
