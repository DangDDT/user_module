import 'package:user_module/core/core.dart';
import 'package:user_module/src/domain/entities/user_info.dart';

import '../base/base_data_mapper_profile.dart';
import '../z_mapper.dart';

class AppUserMapper extends BaseDataMapperProfile<UserInfo, AppUserModel> {
  @override
  AppUserModel mapData(UserInfo entity, Mapper mapper) {
    final mock = AppUserModel.mock();
    return AppUserModel(
      id: entity.id ?? DefaultValueMapperConstants.defaultStringValue,
      email: entity.username ?? DefaultValueMapperConstants.defaultStringValue,
      role: Role.fromString(entity.roleName),

      ///TODO: Bổ sung sau khi api trả về đầy đủ thông tin
      fullName: mock.fullName,
      phoneNumber: mock.phoneNumber,
      address: mock.address,
      avatar: mock.avatar,
      dob: mock.dob,
      gender: mock.gender,
    );
  }
}
