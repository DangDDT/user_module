import 'package:user_module/src/domain/entities/category.dart';
import 'package:user_module/src/domain/entities/commission.dart';
import 'package:user_module/src/domain/models/category_model.dart';

import '../../../../core/constants/default_value_mapper_constants.dart';
import '../../models/commision_model.dart';
import '../base/base_data_mapper_profile.dart';
import '../z_mapper.dart';

class CategoryMapper extends BaseDataMapperProfile<Category, CategoryModel> {
  @override
  CategoryModel mapData(Category entity, Mapper mapper) {
    return CategoryModel(
      id: entity.id ?? DefaultValueMapperConstants.defaultStringValue,
      name: entity.name ?? DefaultValueMapperConstants.defaultStringValue,
      commission: entity.commission != null
          ? mapper.mapData<Commission, CommissionModel>(
              entity.commission!,
            )
          : CommissionModel.error(),
      imageUrl:
          entity.imageUrl ?? DefaultValueMapperConstants.defaultStringValue,
      description: entity.description,
    );
  }
}
