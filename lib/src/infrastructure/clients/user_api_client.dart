// ignore_for_file: depend_on_referenced_packages

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:user_module/src/domain/requests/patch_account_profile_body.dart';

part 'user_api_client.g.dart';

@RestApi()
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;

  @GET("/Auth/userInfo")
  Future getUserInfo(@Header("Authorization") String token);

  @GET("/Category/{id}")
  Future getCategory(@Path("id") String id);

  @PATCH("/Account/profile")
  Future updateUserInfo(@Body() PatchAccountProfileBody body);

  @POST('/File')
  Future uploadFiles(@Part() List<MultipartFile> files);
}
