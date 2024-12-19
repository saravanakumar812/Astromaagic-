class VastuPriceSlotResponse {
  String? message;
  bool? error;
  List<VastuPriceSlotResponseData>? data;

  VastuPriceSlotResponse({this.message, this.error, this.data});

  VastuPriceSlotResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <VastuPriceSlotResponseData>[];
      json['data'].forEach((v) {
        data!.add(new VastuPriceSlotResponseData.fromJson(v));
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

class VastuPriceSlotResponseData {
  int? remedyChargeId;
  String? remedy;
  String? noOfQuestions;
  String? responseTime;
  String? meetingDuration;
  int? fees;

  VastuPriceSlotResponseData(
      {this.remedyChargeId,
        this.remedy,
        this.noOfQuestions,
        this.responseTime,
        this.meetingDuration,
        this.fees});

  VastuPriceSlotResponseData.fromJson(Map<String, dynamic> json) {
    remedyChargeId = json['remedyChargeId'];
    remedy = json['remedy'];
    noOfQuestions = json['noOfQuestions'];
    responseTime = json['responseTime'];
    meetingDuration = json['meetingDuration'];
    fees = json['fees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remedyChargeId'] = this.remedyChargeId;
    data['remedy'] = this.remedy;
    data['noOfQuestions'] = this.noOfQuestions;
    data['responseTime'] = this.responseTime;
    data['meetingDuration'] = this.meetingDuration;
    data['fees'] = this.fees;
    return data;
  }
}