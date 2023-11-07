import 'package:user_module/core/core.dart';
import 'package:user_module/src/domain/entities/upload_result.dart';
import 'package:user_module/src/domain/models/upload_result_model.dart';

import '../../domain.dart';

class UploadResultMapper
    extends BaseDataMapperProfile<UploadResult, UploadResultModel> {
  @override
  UploadResultModel mapData(UploadResult entity, Mapper mapper) {
    return UploadResultModel(
      filename:
          entity.filename ?? DefaultValueMapperConstants.defaultStringValue,
      link: entity.link ?? DefaultValueMapperConstants.defaultStringValue,
      size: entity.size ?? DefaultValueMapperConstants.defaultStringValue,
      type: entity.type ?? DefaultValueMapperConstants.defaultStringValue,
    );
  }
}
