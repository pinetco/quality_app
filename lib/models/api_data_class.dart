class APIDataClass {
  String Message;
  bool IsSuccess;
  dynamic Data;
  int StatusCode;

  APIDataClass({this.Message, this.IsSuccess, this.Data, this.StatusCode});

  factory APIDataClass.fromJson(Map<String, dynamic> json) {
    print(json);
    return APIDataClass(
      Message: json['Message'] as String,
      IsSuccess: json['IsSuccess'] as bool,
      Data: json['Data'] as String,
      StatusCode: json['statusCode'] as int,
    );
  }
}
