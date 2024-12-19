class ScheduleResponse {
  String? message;
  bool? error;
  Resource? resource;

  ScheduleResponse({this.message, this.error, this.resource});

  ScheduleResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    resource = json['resource'] != null
        ? new Resource.fromJson(json['resource'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.resource != null) {
      data['resource'] = this.resource!.toJson();
    }
    return data;
  }
}

class Resource {
  String? bookingUrl;
  String? owner;
  String? ownerType;

  Resource({this.bookingUrl, this.owner, this.ownerType});

  Resource.fromJson(Map<String, dynamic> json) {
    bookingUrl = json['booking_url'];
    owner = json['owner'];
    ownerType = json['owner_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_url'] = this.bookingUrl;
    data['owner'] = this.owner;
    data['owner_type'] = this.ownerType;
    return data;
  }
}