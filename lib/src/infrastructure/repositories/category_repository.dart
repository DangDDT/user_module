import 'package:get/get.dart';
import 'package:user_module/src/domain/domain.dart';
import 'package:user_module/src/domain/entities/category.dart';
import 'package:user_module/src/domain/models/category_model.dart';
import 'package:user_module/src/domain/services/category_service.dart';
import 'package:user_module/src/infrastructure/infrastructure.dart';

import '../../domain/mappers/api_mappers/base/base_error_response_mapper.dart';
import '../../domain/mappers/api_mappers/base/base_success_response_mapper.dart';
import '../clients/user_api_client.dart';

class CategoryRepository extends CategoryService {
  final UserApiClient _userApiClient = Get.find();
  final Mapper _mapper = Mapper.instance;
  final DioClient _dioClient = Get.find(tag: DioClient.tag);
  @override
  Future<CategoryModel> getCategory({required String categoryId}) async {
    final response = await _dioClient.request<Category, Category>(
      () => _userApiClient.getCategory(categoryId),
      decoder: (json) => Category.fromMap(json),
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
      errorResponseMapperType: ErrorResponseMapperType.jsonObject,
    );

    return _mapper.mapData<Category, CategoryModel>(response);
  }
}
