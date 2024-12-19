class NotificationDataModel {
  String? title;
  String? body;
  CustomParam? customParam;

  NotificationDataModel({this.title, this.body, this.customParam});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    customParam = json['customParam'] != null
        ? new CustomParam.fromJson(json['customParam'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    if (this.customParam != null) {
      data['customParam'] = this.customParam!.toJson();
    }
    return data;
  }
}

class CustomParam {
  String? redirectionType;
  int? userServiceId;

  CustomParam({this.redirectionType, this.userServiceId});

  CustomParam.fromJson(Map<String, dynamic> json) {
    redirectionType = json['redirection_type'];
    userServiceId = json['userServiceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redirection_type'] = this.redirectionType;
    data['userServiceId'] = this.userServiceId;
    return data;
  }
}