import 'package:get/get.dart';
import 'package:hommie/models/user_login_model.dart';

class UserResponseModel {
  final String? token;
  final bool? isApproved;

  UserResponseModel({this.token, this.isApproved});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      token: json['token'] as String?,
      isApproved: json['is_approved'] as bool?,
    );
  }
}

class AuthService extends GetConnect {
   
  @override
  void onInit() {
    httpClient.baseUrl = 'http://10.0.2.2:8000'; 
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 8);
  }

  Future<Response<UserResponseModel>> loginuser(UserLoginModel user) async {
    const String loginUrl = '/api/auth/login'; 

    final response = await post(
      loginUrl,
      user.toJson(), 
    );

    if (response.statusCode == 200 && response.body != null) {
      return Response(
        statusCode: 200,
        body: UserResponseModel.fromJson(response.body),
        statusText: response.statusText,
      );
    } else {
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: null,
      );
    }
  }
  Future<Response> sendResetOtp(String phone) {
    return post(
        '/api/auth/sendResetOtp',
        {'phone': phone},
    );
  }
  Future<Response> verifyResetOtp(String phone, String code) {
    return post(
        '/api/auth/verifyResetOtp',
        {'phone': phone, 'code': code},
    );
  }
  Future<Response> resetPassword(String phone, String newPassword) {
    return post(
        '/api/auth/resetPassword',
        {'phone': phone, 'password': newPassword},
    );
  }
}