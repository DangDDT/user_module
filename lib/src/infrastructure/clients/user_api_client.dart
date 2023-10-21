// ignore_for_file: depend_on_referenced_packages

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'user_api_client.g.dart';

@RestApi()
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;

  @GET("/Auth/userInfo")
  Future getUserInfo(@Header("Authorization") String token);
}
