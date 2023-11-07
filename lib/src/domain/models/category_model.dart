// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:user_module/src/domain/models/commision_model.dart';

class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final String? description;
  final CommissionModel commission;
  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description,
    required this.commission,
  });

  factory CategoryModel.loading() {
    return CategoryModel(
      id: '',
      name: 'Đang tải...',
      imageUrl: '',
      description: 'Đang tải...',
      commission: CommissionModel.loading(),
    );
  }

  factory CategoryModel.error() {
    return CategoryModel(
      id: '',
      name: 'Đã xảy ra lỗi',
      imageUrl: '',
      description: 'Đã xảy ra lỗi',
      commission: CommissionModel.error(),
    );
  }
}
