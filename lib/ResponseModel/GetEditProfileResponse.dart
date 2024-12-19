class EditProfileResponse {
  String? message;
  bool? error;
  EditProfileResponseData? data;

  EditProfileResponse({this.message, this.error, this.data});

  EditProfileResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new EditProfileResponseData.fromJson(json['data']) : null;
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

class EditProfileResponseData {
  String? userName;
  String? areaOfBirth;
  String? cityOfBirth;
  String? stateOfBirth;
  String? dateOfBirth;
  String? timeOfBirth;
  String? maritalStatus;
  String? marriageDate;
  String? employment;
  String? userLanguage;
  String? userCountry;
  String? userMobile;
  String? profileImage;

  EditProfileResponseData(
      {this.userName,
        this.areaOfBirth,
        this.cityOfBirth,
        this.stateOfBirth,
        this.dateOfBirth,
        this.timeOfBirth,
        this.maritalStatus,
        this.marriageDate,
        this.employment,
        this.userLanguage,
        this.userCountry,
        this.profileImage,
        this.userMobile});

  EditProfileResponseData.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    areaOfBirth = json['areaOfBirth'];
    cityOfBirth = json['cityOfBirth'];
    stateOfBirth = json['stateOfBirth'];
    dateOfBirth = json['dateOfBirth'];
    timeOfBirth = json['timeOfBirth'];
    maritalStatus = json['maritalStatus'];
    marriageDate = json['marriageDate'];
    employment = json['employment'];
    userLanguage = json['userLanguage'];
    userCountry = json['userCountry'];
    userMobile = json['userMobile'];
    profileImage = json['profileImage'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['areaOfBirth'] = this.areaOfBirth;
    data['cityOfBirth'] = this.cityOfBirth;
    data['stateOfBirth'] = this.stateOfBirth;
    data['dateOfBirth'] = this.dateOfBirth;
    data['timeOfBirth'] = this.timeOfBirth;
    data['maritalStatus'] = this.maritalStatus;
    data['marriageDate'] = this.marriageDate;
    data['employment'] = this.employment;
    data['userLanguage'] = this.userLanguage;
    data['userCountry'] = this.userCountry;
    data['userMobile'] = this.userMobile;
    data['profileImage'] = this.profileImage;
    return data;
  }
}