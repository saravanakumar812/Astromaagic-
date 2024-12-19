class SignUpResponse {
  String? message;
  bool? error;
  String? token;
  int? userId;

  SignUpResponse({this.message, this.error, this.token, this.userId});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    token = json['token'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['token'] = this.token;
    data['userId'] = this.userId;
    return data;
  }
}
