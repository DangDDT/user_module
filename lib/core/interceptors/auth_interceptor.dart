// ignore_for_file: unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_x_package;
import 'package:user_module/core/module_configs.dart';
import 'package:user_module/src/domain/services/isar/daos/authenticated_user_dao.dart';
import 'package:user_module/src/domain/services/isar/dtos/authenticated_user_dto.dart';
import 'package:user_module/src/presentation/controllers/auth_controller.dart';

import '../utils/helpers/logger.dart';

class AuthInterceptor implements Interceptor {
  static final AuthController _authController =
      get_x_package.Get.find(tag: AuthController.tag);

  static final AuthenticatedUserDAO _localAuthRepository =
      get_x_package.Get.find(tag: AuthenticatedUserDAO.tag);

  static final ModuleConfig _config =
      get_x_package.Get.find(tag: ModuleConfig.tag);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken = _authController.accessToken;
      options.headers['Authorization'] = 'Bearer $accessToken';
      options.headers['Accept'] = '*/*';
      return handler.next(options);
    } catch (error, stackTrace) {
      Logger.log(
        error.toString(),
        name: 'RefreshTokenInterceptor_onRequest',
        stackTrace: stackTrace,
      );
      return handler.next(options);
    }
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response != null) {
      if (error.response!.statusCode == 401) {
        try {
          final requestOptions = error.requestOptions;
          final String? token = await _config.onRefreshTokenCallback?.call();
          if (token == null) return handler.next(error);
          final currentUser = _authController.currentUser.value;
          if (currentUser == null) return handler.next(error);
          _localAuthRepository.updateAppUser(
            AuthenticatedUserDTO.fromAuthUser(
              currentUser.copyWith(token: token),
            ),
          );
          final authUserData = currentUser;
          if (authUserData == null) return handler.next(error);
          final accessToken = _authController.accessToken;
          final opts = Options(method: requestOptions.method);
          final dioClient = Dio();
          dioClient.options.headers['Authorization'] = 'Bearer $accessToken';
          dioClient.options.headers['Accept'] = '*/*';
          final response = await dioClient.request<dynamic>(
            requestOptions.path,
            options: opts,
            cancelToken: requestOptions.cancelToken,
            onReceiveProgress: requestOptions.onReceiveProgress,
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
          );

          return handler.resolve(response);
        } catch (e) {
          return handler.next(error);
        }
      } else {
        return handler.next(error);
      }
    }
    return handler.next(error);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) =>
      handler.next(response);

  // static Future<AuthenticatedUser?> refreshToken() async {
  //   try {
  //     final currentUser = _authController.currentUser.value;
  //     if (currentUser == null) return null;
  //     final localAuthData = await _localAuthRepository.getAppUser();
  //     if (localAuthData == null) return null;
  //     final refreshToken = localAuthData.refreshToken;
  //     final accessToken = localAuthData.token;
  //     final newAuthData = await _config.onRefreshTokenApiCallback
  //         ?.call(refreshToken, accessToken);
  //     final newAuthDataDTO = AuthenticatedUserDTO.fromAuthUser(newAuthData);
  //     _localAuthRepository.updateAppUser(newAuthDataDTO);
  //     final newAuthDataUpdated = await _localAuthRepository.getAppUser();
  //     return newAuthDataUpdated?.toAuthUser();
  //   } catch (e, stackStrace) {
  //     Logger.log(
  //       e.toString(),
  //       stackTrace: stackStrace,
  //       name: 'ON_REFRESH_TOKEN_ERROR',
  //     );
  //     rethrow;
  //   }
  // }
}
