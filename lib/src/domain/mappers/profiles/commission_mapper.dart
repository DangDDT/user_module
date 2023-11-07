import 'package:user_module/src/domain/entities/commission.dart';
import 'package:user_module/src/domain/models/commision_model.dart';

import '../../../../core/constants/default_value_mapper_constants.dart';
import '../base/base_data_mapper_profile.dart';
import '../z_mapper.dart';

class CommissionMapper
    extends BaseDataMapperProfile<Commission, CommissionModel> {
  @override
  CommissionModel mapData(Commission entity, Mapper mapper) {
    return CommissionModel(
      id: entity.id ?? DefaultValueMapperConstants.defaultStringValue,
      dateOfApply: entity.dateOfApply ??
          DefaultValueMapperConstants.defaultDateTimeValue,
      value: entity.commisionValue?.toDouble() ??
          DefaultValueMapperConstants.defaultDoubleValue,
    );
  }
}
