class AvailableDateResponse {
  String? message;
  bool? error;
  EventSlot? eventSlot;

  AvailableDateResponse({this.message, this.error, this.eventSlot});

  AvailableDateResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    eventSlot = json['eventSlot'] != null
        ? new EventSlot.fromJson(json['eventSlot'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.eventSlot != null) {
      data['eventSlot'] = this.eventSlot!.toJson();
    }
    return data;
  }
}

class EventSlot {
  bool? inviteePublisherError;
  String? today;
  String? availabilityTimezone;
  List<Days>? days;
  CurrentUser? currentUser;

  EventSlot(
      {this.inviteePublisherError,
        this.today,
        this.availabilityTimezone,
        this.days,
        this.currentUser});

  EventSlot.fromJson(Map<String, dynamic> json) {
    inviteePublisherError = json['invitee_publisher_error'];
    today = json['today'];
    availabilityTimezone = json['availability_timezone'];
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(new Days.fromJson(v));
      });
    }
    currentUser = json['current_user'] != null
        ? new CurrentUser.fromJson(json['current_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invitee_publisher_error'] = this.inviteePublisherError;
    data['today'] = this.today;
    data['availability_timezone'] = this.availabilityTimezone;
    if (this.days != null) {
      data['days'] = this.days!.map((v) => v.toJson()).toList();
    }
    if (this.currentUser != null) {
      data['current_user'] = this.currentUser!.toJson();
    }
    return data;
  }
}

class Days {
  String? date;
  String? status;
  List<Spots>? spots;

  Days({this.date, this.status, this.spots,});

  Days.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
    if (json['spots'] != null) {
      spots = <Spots>[];
      json['spots'].forEach((v) {
        spots!.add(new Spots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['status'] = this.status;
    if (this.spots != null) {
      data['spots'] = this.spots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Spots {
  String? status;
  String? startTime;
  int? inviteesRemaining;

  Spots({this.status, this.startTime, this.inviteesRemaining});

  Spots.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    startTime = json['start_time'];
    inviteesRemaining = json['invitees_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['start_time'] = this.startTime;
    data['invitees_remaining'] = this.inviteesRemaining;
    return data;
  }
}

class CurrentUser {
  Null? id;
  Null? email;
  Null? locale;
  Null? dateNotation;
  Null? timeNotation;
  Null? avatarUrl;
  bool? isPretending;
  Diagnostics? diagnostics;

  CurrentUser(
      {this.id,
        this.email,
        this.locale,
        this.dateNotation,
        this.timeNotation,
        this.avatarUrl,
        this.isPretending,
        this.diagnostics});

  CurrentUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    locale = json['locale'];
    dateNotation = json['date_notation'];
    timeNotation = json['time_notation'];
    avatarUrl = json['avatar_url'];
    isPretending = json['is_pretending'];
    diagnostics = json['diagnostics'] != null
        ? new Diagnostics.fromJson(json['diagnostics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['locale'] = this.locale;
    data['date_notation'] = this.dateNotation;
    data['time_notation'] = this.timeNotation;
    data['avatar_url'] = this.avatarUrl;
    data['is_pretending'] = this.isPretending;
    if (this.diagnostics != null) {
      data['diagnostics'] = this.diagnostics!.toJson();
    }
    return data;
  }
}

class Diagnostics {
  bool? available;
  bool? enabled;

  Diagnostics({this.available, this.enabled});

  Diagnostics.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['enabled'] = this.enabled;
    return data;
  }
}