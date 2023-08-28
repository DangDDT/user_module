// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:user_module/core/core.dart';
import 'package:user_module/src/domain/services/isar/daos/authenticated_user_dao.dart';
import 'package:user_module/src/infrastructure/local_databases/isar/authenticated_user_dao_impl.dart';

import '../src/domain/domain.dart';
import '../src/infrastructure/infrastructure.dart';
import '../src/presentation/controllers/auth_controller.dart';

class GlobalBinding {
  static Future<void> setUpLocator({
    required bool isShowLog,
    required BaseUrlConfig baseUrlConfig,
    required String homeRoute,
    LoginViewConfig? viewConfig,
    required Future<AuthenticatedUser?> Function(
      String refreshToken,
      String accessToken,
    )? onRefreshTokenApiCallback,
    MockConfig? mockConfig,
  }) async {
    Get
      ..put<ModuleConfig>(
        ModuleConfig(
          isShowLog: isShowLog,
          baseUrlConfig: baseUrlConfig,
          loginViewConfig: viewConfig,
          homeRoute: homeRoute,
          onRefreshTokenApiCallback: onRefreshTokenApiCallback,
          mockConfig: mockConfig,
        ),
        tag: ModuleConfig.tag,
      )
      ..put<AuthenticatedUserDAO>(
        AuthenticatedUserDAOImpl(),
        tag: AuthenticatedUserDAO.tag,
      )
      ..put<AuthController>(
        AuthController(),
        permanent: true,
        tag: AuthController.tag,
      );

    Mapper.instance.registerMappers([]);

    final dioClient = Get.put<DioClient>(
      DioClient(
        baseUrl: baseUrlConfig.baseUrl,
      ),
      tag: DioClient.tag,
    );

    ///TODO: ApiClient
  }
}
