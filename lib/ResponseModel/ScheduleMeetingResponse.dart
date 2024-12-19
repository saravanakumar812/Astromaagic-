class ScheduleMeetingResponse {
  String? message;
  bool? error;
  ScheduleMeetingResponseData? data;

  ScheduleMeetingResponse({this.message, this.error, this.data});

  ScheduleMeetingResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new ScheduleMeetingResponseData.fromJson(json['data']) : null;
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

class ScheduleMeetingResponseData {
  String? scheduleMeeting;

  ScheduleMeetingResponseData({this.scheduleMeeting});

  ScheduleMeetingResponseData.fromJson(Map<String, dynamic> json) {
    scheduleMeeting = json['scheduleMeeting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleMeeting'] = this.scheduleMeeting;
    return data;
  }
}
