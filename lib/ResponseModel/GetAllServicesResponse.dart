class GetAllServicesResponse {
  String? message;
  bool? error;
  List<GetAllServicesData>? data;

  GetAllServicesResponse({this.message, this.error, this.data});

  GetAllServicesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetAllServicesData>[];
      json['data'].forEach((v) {
        data!.add(new GetAllServicesData.fromJson(v));
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

class GetAllServicesData {
  int? serviceId;
  String? services;
  String? serviceDescription;

  GetAllServicesData({this.serviceId, this.services, this.serviceDescription});

  GetAllServicesData.fromJson(Map<String, dynamic> json) {
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
