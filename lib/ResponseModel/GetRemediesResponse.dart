class GetRemediesResponse {
  String? message;
  bool? error;
  List<GetRemediesData>? data;

  GetRemediesResponse({this.message, this.error, this.data});

  GetRemediesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetRemediesData>[];
      json['data'].forEach((v) {
        data!.add(new GetRemediesData.fromJson(v));
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

class GetRemediesData {
  int? remedyId;
  String? remedy;

  GetRemediesData({this.remedyId, this.remedy});

  GetRemediesData.fromJson(Map<String, dynamic> json) {
    remedyId = json['remedyId'];
    remedy = json['remedy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remedyId'] = this.remedyId;
    data['remedy'] = this.remedy;
    return data;
  }
}
