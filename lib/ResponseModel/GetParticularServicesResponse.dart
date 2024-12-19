class GetParticularServicesResponse {
  String? message;
  bool? error;
  GetParticularData? data;

  GetParticularServicesResponse({this.message, this.error, this.data});

  GetParticularServicesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null
        ? new GetParticularData.fromJson(json['data'])
        : null;
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

class GetParticularData {
  int? serviceId;
  String? services;
  String? serviceDescription;

  GetParticularData({this.serviceId, this.services, this.serviceDescription});

  GetParticularData.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    services = json['services'];
    serviceDescription = json['serviceDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = this.serviceId;
    data['services'] = this.services;
    data['serviceDescription'] = this.serviceDescription;
    return data;
  }
}
