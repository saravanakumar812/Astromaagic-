class GetViewPdfResponse {
  String? message;
  bool? error;
  GetViewPdfResponseData? data;

  GetViewPdfResponse({this.message, this.error, this.data});

  GetViewPdfResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new GetViewPdfResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetViewPdfResponseData {
  String? pdf;

  GetViewPdfResponseData({this.pdf});

  GetViewPdfResponseData.fromJson(Map<String, dynamic> json) {
    pdf = json['pdf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pdf'] = this.pdf;
    return data;
  }
}