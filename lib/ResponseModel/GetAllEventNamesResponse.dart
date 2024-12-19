class GetAllEventNamesResponse {
  String? message;
  bool? error;
  List<Events>? events;

  GetAllEventNamesResponse({this.message, this.error, this.events});

  GetAllEventNamesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String? color;
  String? description;
  String? name;
  String? slug;
  String? uuid;

  Events({this.color, this.description, this.name, this.slug, this.uuid});

  Events.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    description = json['description'];
    name = json['name'];
    slug = json['slug'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['description'] = this.description;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['uuid'] = this.uuid;
    return data;
  }
}