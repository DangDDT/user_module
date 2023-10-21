// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:user_module/core/core.dart';
import 'package:user_module/src/domain/mappers/profiles/app_user_mapper.dart';
import 'package:user_module/src/domain/services/isar/daos/authenticated_user_dao.dart';
import 'package:user_module/src/infrastructure/local_databases/isar/authenticated_user_dao_impl.dart';

import '../src/domain/domain.dart';
import '../src/domain/services/user_service.dart';
import '../src/infrastructure/clients/user_api_client.dart';
import '../src/infrastructure/infrastructure.dart';
import '../src/infrastructure/repositories/user_repository.dart';
import '../src/presentation/controllers/auth_controller.dart';

class GlobalBinding {
  static Future<void> setUpLocator({
    required bool isShowLog,
    required BaseUrlConfig baseUrlConfig,
    required String homeRoute,
    LoginViewConfig? viewConfig,
    OnGetFirebaseToken? onGetFirebaseTokenCallback,
    MockConfig? mockConfig,
  }) async {
    Get.put<ModuleConfig>(
      ModuleConfig(
        isShowLog: isShowLog,
        baseUrlConfig: baseUrlConfig,
        loginViewConfig: viewConfig,
        homeRoute: homeRoute,
        onGetFirebaseToken: onGetFirebaseTokenCallback,
        mockConfig: mockConfig,
      ),
      tag: ModuleConfig.tag,
    );

    Get.put<AuthenticatedUserDAO>(
      AuthenticatedUserDAOImpl(),
      tag: AuthenticatedUserDAO.tag,
    );
    Mapper.instance.registerMappers([
      AppUserMapper(),
    ]);

    final dioClient = Get.put<DioClient>(
      DioClient(
        baseUrl: baseUrlConfig.baseUrl,
      ),
      tag: DioClient.tag,
    );

    ///TODO: ApiClients
    Get.put<UserApiClient>(
      UserApiClient(
        dioClient.dio,
        baseUrl: baseUrlConfig.baseUrl,
      ),
    );

    ///TODO: Services

    Get.put<UserService>(
      UserRepository(),
    );
    Get.put<AuthController>(
      AuthController(),
      permanent: true,
      tag: AuthController.tag,
    );
  }
}
