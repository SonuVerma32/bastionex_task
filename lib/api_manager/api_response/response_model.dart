class ResponseModel {
  int statusCode;
  String message;
  dynamic data;

  ResponseModel({this.data, required this.message, required this.statusCode});
}
