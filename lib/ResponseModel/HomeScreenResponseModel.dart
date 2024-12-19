class HomeScreenResponse {
  String? message;
  bool? error;
  List<Data>? data;

  HomeScreenResponse({this.message, this.error, this.data});

  HomeScreenResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  List<Details>? details;

  Data({this.details});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? serviceId;
  String? services;
  String? serviceDescription;
  String? bannerImage;

  Details(
      {this.serviceId,
        this.services,
        this.serviceDescription,
        this.bannerImage});

  Details.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    services = json['services'];
    serviceDescription = json['serviceDescription'];
    bannerImage = json['bannerImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = this.serviceId;
    data['services'] = this.services;
    data['serviceDescription'] = this.serviceDescription;
    data['bannerImage'] = this.bannerImage;
    return data;
  }
}