import 'package:get/get.dart';
import 'package:user_module/core/core.dart';
import 'package:user_module/core/utils/helpers/logger.dart';
import 'package:user_module/src/domain/models/category_model.dart';
import 'package:user_module/src/domain/services/category_service.dart';

class UserCategoryController extends GetxController {
  final CategoryService _categoryService = Get.find();

  UserCategoryController({
    required this.categoryId,
    required this.config,
  });

  final String categoryId;
  final UserCategoryViewConfig config;

  final Rxn<CategoryModel> _category = Rxn<CategoryModel>();
  Rxn<CategoryModel> get category => _category;
  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    _loadCategory();
  }

  Future<void> _loadCategory() async {
    _isLoading.call(true);
    try {
      final category = await _categoryService.getCategory(
        categoryId: categoryId,
      );
      _category.value = category;
    } catch (e, stackTrace) {
      Logger.log(
        e.toString(),
        name: 'PartnerCategoryController_loadCategory()',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } finally {
      _isLoading.call(false);
    }
  }
}
