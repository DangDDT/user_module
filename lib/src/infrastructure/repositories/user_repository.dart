import 'package:get/get.dart';
import 'package:user_module/src/domain/mappers/api_mappers/base/base_error_response_mapper.dart';
import 'package:user_module/src/domain/mappers/api_mappers/base/base_success_response_mapper.dart';
import 'package:user_module/src/domain/models/app_user.dart';
import 'package:user_module/src/domain/services/user_service.dart';

import '../../domain/domain.dart';
import '../../domain/entities/user_info.dart';
import '../clients/user_api_client.dart';
import '../infrastructure.dart';

class UserRepository extends UserService {
  final UserApiClient _userApiClient = Get.find();
  final Mapper _mapper = Mapper.instance;

  @override
  Future<AppUserModel> getUserInfo({
    required String token,
  }) async {
    final response = await DioClient.request<UserInfo, UserInfo>(
      () => _userApiClient.getUserInfo(token),
      decoder: (json) => UserInfo.fromMap(json),
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
      errorResponseMapperType: ErrorResponseMapperType.jsonObject,
    );
    return _mapper.mapData<UserInfo, AppUserModel>(response);
  }
}
