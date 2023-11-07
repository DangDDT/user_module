import 'package:user_module/core/core.dart';
import 'package:user_module/src/domain/entities/user_info.dart';

import '../base/base_data_mapper_profile.dart';
import '../z_mapper.dart';

class AppUserMapper extends BaseDataMapperProfile<UserInfo, AppUserModel> {
  @override
  AppUserModel mapData(UserInfo entity, Mapper mapper) {
    return AppUserModel(
        id: entity.id ?? DefaultValueMapperConstants.defaultStringValue,
        email:
            entity.username ?? DefaultValueMapperConstants.defaultStringValue,
        role: Role.fromString(entity.roleName),
        fullName: entity.user?.fullname ??
            DefaultValueMapperConstants.defaultStringValue,
        phoneNumber: entity.user?.phone ??
            DefaultValueMapperConstants.defaultStringValue,
        address: entity.user?.address ??
            DefaultValueMapperConstants.defaultStringValue,
        avatar: entity.user?.imageUrl ??
            DefaultValueMapperConstants.defaultStringValue,
        dob: entity.user?.dateOfBirth ??
            DefaultValueMapperConstants.defaultDateTimeValue,
        gender: Gender.fromCode(entity.user?.gender),
        extraData: {
          'categoryId': entity.user?.categoryId,
          'commissionId': DefaultValueMapperConstants.defaultStringValue,
        });
  }
}
