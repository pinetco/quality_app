class APIDataClass {
  String Message;
  bool IsSuccess;
  dynamic Data;

  APIDataClass({this.Message, this.IsSuccess, this.Data});

  factory APIDataClass.fromJson(Map<String, dynamic> json) {
    return APIDataClass(
      Message: json['Message'] as String,
      IsSuccess: json['IsSuccess'] as bool,
      Data: json['Data'] as String,
    );
  }
}
