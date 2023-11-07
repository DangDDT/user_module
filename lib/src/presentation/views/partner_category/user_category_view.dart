// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_module/core/core.dart';
import 'package:user_module/src/presentation/shared/circle_avatar_with_error_handler.dart';

import 'user_category_controller.dart';

class UserCategoryViewConfig {
  final bool isShowCommission;
  const UserCategoryViewConfig({
    this.isShowCommission = true,
  });
}

class UserCategoryView extends GetView<UserCategoryController> {
  const UserCategoryView({
    super.key,
    required this.categoryId,
    this.config = const UserCategoryViewConfig(),
  });
  final String categoryId;
  final UserCategoryViewConfig config;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserCategoryController>(
      init: UserCategoryController(
        categoryId: categoryId,
        config: config,
      ),
      builder: (controller) {
        return Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const _DataView();
        });
      },
    );
  }
}

class _DataView extends GetView<UserCategoryController> {
  const _DataView();

  @override
  Widget build(BuildContext context) {
    final category = controller.category.value!;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatarWithErrorHandler(
                  avatarUrl: category.imageUrl,
                  fullName: category.name,
                  radius: 24,
                ),
                title: Text(
                  category.name.toPascalCase(),
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.theme.colorScheme.primary,
                  ),
                ),
                subtitle: Text(
                  category.description?.toUpperCaseFirstWord() ??
                      'Không có dữ liệu',
                  style: context.textTheme.bodyMedium,
                ),
              ),
              if (controller.config.isShowCommission) ...[
                const Divider(),
                ListTile(
                  isThreeLine: true,
                  leading: const Icon(Icons.monetization_on, size: 24),
                  title: const Text('Chiết khấu:'),
                  subtitle: const Text(
                    'Đây là tỷ lệ chiết khấu cửa hàng sẽ nhận được khi cộng tác với bạn trên dịch vụ của bạn.',
                  ),
                  trailing: Text(
                    '${category.commission.value} %',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  isThreeLine: true,
                  leading: const Icon(Icons.calendar_today, size: 24),
                  title: const Text('Ngày áp dụng'),
                  subtitle: const Text(
                    'Đây là ngày mà chiết khấu này bắt đầu được áp dụng.',
                  ),
                  trailing: Text(
                    category.commission.dateOfApply.toDateReadable(),
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.theme.colorScheme.primary,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
