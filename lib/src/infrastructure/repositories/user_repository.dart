import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:user_module/core/module_configs.dart';
import 'package:user_module/src/domain/mappers/api_mappers/base/base_error_response_mapper.dart';
import 'package:user_module/src/domain/mappers/api_mappers/base/base_success_response_mapper.dart';
import 'package:user_module/src/domain/models/app_user.dart';
import 'package:user_module/src/domain/services/user_service.dart';

import '../../domain/domain.dart';
import '../../domain/entities/user_info.dart';
import '../../domain/requests/patch_account_profile_body.dart';
import '../clients/user_api_client.dart';
import '../infrastructure.dart';

class UserRepository extends UserService {
  final UserApiClient _userApiClient = Get.find();
  final Mapper _mapper = Mapper.instance;
  final DioClient _dioClient = Get.find(tag: DioClient.tag);
  final ModuleConfig _moduleConfig = Get.find(tag: ModuleConfig.tag);

  @override
  Future<AppUserModel> getUserInfo({
    required String token,
  }) async {
    try {
      final accessToken = 'Bearer $token';
      final response = await dio.Dio().get(
        '${_moduleConfig.baseUrlConfig.baseUrl}/Auth/userInfo',
        options: dio.Options(
          headers: {
            'Authorization': accessToken,
          },
        ),
      );

      final UserInfo userInfo = UserInfo.fromMap(response.data);
      return _mapper.mapData<UserInfo, AppUserModel>(userInfo);
    } catch (e) {
      throw UnauthorizedRemoteException();
    }
  }

  @override
  Future<bool> updateUserInfo({required PatchAccountProfileBody body}) async {
    await _dioClient.request(
      () => _userApiClient.updateUserInfo(body),
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
      errorResponseMapperType: ErrorResponseMapperType.jsonObject,
    );
    return true;
  }
}
