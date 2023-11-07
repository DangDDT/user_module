import '../models/category_model.dart';

abstract class CategoryService {
  Future<CategoryModel> getCategory({required String categoryId});
}
