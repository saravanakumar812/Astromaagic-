class GetAllCountryResponse {
  String? message;
  bool? error;
  int? dataPerPage;
  int? pageNo;
  int? totalPages;
  List<GetAllCountryResponseData>? data;

  GetAllCountryResponse(
      {this.message,
      this.error,
      this.dataPerPage,
      this.pageNo,
      this.totalPages,
      this.data});

  GetAllCountryResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    dataPerPage = json['dataPerPage'];
    pageNo = json['pageNo'];
    totalPages = json['TotalPages'];
    if (json['data'] != null) {
      data = <GetAllCountryResponseData>[];
      json['data'].forEach((v) {
        data!.add(new GetAllCountryResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['dataPerPage'] = this.dataPerPage;
    data['pageNo'] = this.pageNo;
    data['TotalPages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllCountryResponseData {
  int? countryId;
  String? countryName;

  GetAllCountryResponseData({this.countryId, this.countryName});

  GetAllCountryResponseData.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    return data;
  }
}
