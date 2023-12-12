// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:user_module/core/core.dart';
import 'package:user_module/src/domain/mappers/profiles/app_user_mapper.dart';
import 'package:user_module/src/domain/mappers/profiles/category_mapper.dart';
import 'package:user_module/src/domain/mappers/profiles/commission_mapper.dart';
import 'package:user_module/src/domain/mappers/profiles/upload_result_mapper.dart';
import 'package:user_module/src/domain/services/category_service.dart';
import 'package:user_module/src/domain/services/isar/daos/authenticated_user_dao.dart';
import 'package:user_module/src/infrastructure/local_databases/isar/authenticated_user_dao_impl.dart';

import '../src/domain/domain.dart';
import '../src/domain/services/file_service.dart';
import '../src/domain/services/user_service.dart';
import '../src/infrastructure/clients/user_api_client.dart';
import '../src/infrastructure/infrastructure.dart';
import '../src/infrastructure/repositories/category_repository.dart';
import '../src/infrastructure/repositories/file_repository.dart';
import '../src/infrastructure/repositories/user_repository.dart';
import '../src/presentation/controllers/auth_controller.dart';

class GlobalBinding {
  static Future<void> setUpLocator({
    required bool isShowLog,
    required BaseUrlConfig baseUrlConfig,
    required String homeRoute,
    LoginViewConfig? viewConfig,
    OnGetFirebaseToken? onGetFirebaseTokenCallback,
    OnRefreshTokenCallback? onRefreshTokenCallback,
    MockConfig? mockConfig,
  }) async {
    Get.put<ModuleConfig>(
      ModuleConfig(
        isShowLog: isShowLog,
        baseUrlConfig: baseUrlConfig,
        loginViewConfig: viewConfig,
        homeRoute: homeRoute,
        onGetFirebaseToken: onGetFirebaseTokenCallback,
        onRefreshTokenCallback: onRefreshTokenCallback,
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
      CategoryMapper(),
      CommissionMapper(),
      UploadResultMapper(),
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

    Get
      ..put<UserService>(
        UserRepository(),
      )
      ..put<CategoryService>(
        CategoryRepository(),
      )
      ..put<FileService>(
        FileRepository(),
      );

    Get.put<AuthController>(
      AuthController(),
      permanent: true,
      tag: AuthController.tag,
    );
  }
}
