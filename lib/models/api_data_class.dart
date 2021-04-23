class APIDataClass {
  String message;
  bool isSuccess;
  dynamic data;
  int statusCode;
  bool validation;
  bool isInternetConnected;

  APIDataClass({this.message, this.isSuccess, this.data, this.statusCode, this.validation = false, this.isInternetConnected});

  factory APIDataClass.fromJson(Map<String, dynamic> json) {
    return APIDataClass(
      message: json['Message'] as String,
      isSuccess: json['IsSuccess'] as bool,
      data: json['Data'] as String,
      statusCode: json['StatusCode'] as int,
      validation: json['Validation'] as bool,
      isInternetConnected: json['isInternetConnected'] as bool,
    );
  }
}
