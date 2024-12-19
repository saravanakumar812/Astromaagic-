class GetUserServiceResponse {
  String? message;
  bool? error;
  List<UserServiceData>? data;

  GetUserServiceResponse({this.message, this.error, this.data});

  GetUserServiceResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <UserServiceData>[];
      json['data'].forEach((v) {
        data!.add(new UserServiceData.fromJson(v));
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

class UserServiceData {
  int? userServiceId;
  dynamic? userId;
  String? userName;
  int? serviceId;
  String? services;
  String? serviceDescription;
  int? remedyId;
  String? remedy;
  int? remedyChargeId;
  String? noOfQuestions;
  String? responseTime;
  String? meetingDuration;
  String? meetingDate;
  String? meetingTime;
  int? fees;
  String? serviceStatus;
  String? profileImage;
  String? horoscopePDF;
  String? createdDateTime;
  String? date;
  String? day;
  dynamic? timeStamp;

  UserServiceData(
      {this.userServiceId,
        this.userId,
        this.userName,
        this.serviceId,
        this.services,
        this.serviceDescription,
        this.remedyId,
        this.remedy,
        this.remedyChargeId,
        this.noOfQuestions,
        this.responseTime,
        this.meetingDuration,
        this.meetingDate,
        this.meetingTime,
        this.fees,
        this.serviceStatus,
        this.profileImage,
        this.horoscopePDF,
        this.createdDateTime,
        this.date,
        this.day,
        this.timeStamp});

  UserServiceData.fromJson(Map<String, dynamic> json) {
    userServiceId = json['userServiceId'] ?? " ";
    userId = json['userId'] ?? "";
    userName = json['userName'] ?? "";
    serviceId = json['serviceId'] ?? "";
    services = json['services'] ?? "";
    serviceDescription = json['serviceDescription'] ?? "";
    remedyId = json['remedyId'] ?? "";
    remedy = json['remedy'] ?? "";
    remedyChargeId = json['remedyChargeId'] ?? "";
    noOfQuestions = json['noOfQuestions'] ?? "";
    responseTime = json['responseTime'] ?? "";
    meetingDuration = json['meetingDuration'] ?? '';
    meetingDate = json['meetingDate'] ?? "";
    meetingTime = json['meetingTime'] ?? "";
    fees = json['fees'] ?? "";
    serviceStatus = json['serviceStatus'] ?? "";
    profileImage = json['profileImage'] ?? "";
    horoscopePDF = json['horoscopePDF'] ?? "";
    createdDateTime = json['createdDateTime'] ?? "";
    date = json['date'] ?? "";
    day = json['day'] ?? "";
    timeStamp = json['time_stamp'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userServiceId'] = this.userServiceId;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['serviceId'] = this.serviceId;
    data['services'] = this.services;
    data['serviceDescription'] = this.serviceDescription;
    data['remedyId'] = this.remedyId;
    data['remedy'] = this.remedy;
    data['remedyChargeId'] = this.remedyChargeId;
    data['noOfQuestions'] = this.noOfQuestions;
    data['responseTime'] = this.responseTime;
    data['meetingDuration'] = this.meetingDuration;
    data['meetingDate'] = this.meetingDate;
    data['meetingTime'] = this.meetingTime;
    data['fees'] = this.fees;
    data['serviceStatus'] = this.serviceStatus;
    data['profileImage'] = this.profileImage;
    data['horoscopePDF'] = this.horoscopePDF;
    data['createdDateTime'] = this.createdDateTime;
    data['date'] = this.date;
    data['day'] = this.day;
    data['time_stamp'] = this.timeStamp;
    return data;
  }
}


