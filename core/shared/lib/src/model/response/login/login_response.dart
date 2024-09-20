class LoginResponse {
  int? status;
  LoginResponseData? data;
  String? message;

  LoginResponse({this.status, this.data, this.message});
}

class LoginResponseData {
  String? accessToken;

  LoginResponseData({this.accessToken});
}
