import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_package;
import 'package:user_module/src/presentation/controllers/auth_controller.dart';

import '../../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../../domain/mappers/api_mappers/base/base_error_response_mapper.dart';
import '../../../domain/mappers/api_mappers/base/base_success_response_mapper.dart';

class DioClient {
  static final ModuleConfig _config =
      get_package.Get.find<ModuleConfig>(tag: ModuleConfig.tag);
  static final tag = "${UserModule.packageName.toUpperCase()}|DIO_CLIENT";

  ///Truyền api key nếu có
  String? apiKey;

  final dio_package.Dio _dio;
  dio_package.Dio get dio => _dio;

  final SuccessResponseMapperType successResponseMapperType;
  final ErrorResponseMapperType errorResponseMapperType;
  final String baseUrl;
  DioClient({
    this.baseUrl = DefaultValueMapperConstants.defaultStringValue,
    this.errorResponseMapperType =
        ResponseMapperConstants.defaultErrorResponseMapperType,
    this.successResponseMapperType =
        ResponseMapperConstants.defaultSuccessResponseMapperType,
    this.apiKey,
    bool isUseAuthInterceptor = true,
  }) : _dio = dio_package.Dio(
          dio_package.BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: ServerTimeoutConstants.connectTimeout,
            sendTimeout: ServerTimeoutConstants.connectTimeout,
            receiveTimeout: ServerTimeoutConstants.connectTimeout,
            headers: apiKey != null ? {'apiKey': apiKey} : null,
          ),
        )..interceptors.addAll(
            [
              if (kDebugMode && _config.isShowLog == true)
                TalkerDioLoggerInterceptor(),
              if (isUseAuthInterceptor) AuthInterceptor(),
            ],
          );

  Future<T> request<T, D>(
    Function() request, {
    // ignore: avoid-dynamic
    Decoder<D>? decoder,
    SuccessResponseMapperType? successResponseMapperType,
    ErrorResponseMapperType? errorResponseMapperType,
    BaseErrorResponseMapper? errorResponseMapper,
    DataFilterMapperType? dataFilterType,
  }) async {
    try {
      final response = await request.call();
      var result = BaseSuccessResponseMapper<D, T>.fromType(
        successResponseMapperType ??
            ResponseMapperConstants.defaultSuccessResponseMapperType,
      ).map(response, decoder);
      if (dataFilterType != null) {
        result =
            DataFilterMapper<T>.fromType(dataFilterType).filterData(result);
      }
      return result;
    } on CustomException {
      rethrow;
    } on UnauthorizedRemoteException {
      get_package.Get.dialog(
        AlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Phiên đăng nhập đã hết hạn'),
          actions: [
            TextButton(
              onPressed: () {
                final AuthController authController =
                    get_package.Get.find(tag: AuthController.tag);
                authController.logout();
              },
              child: const Text('Quay về màn hình đăng nhập'),
            ),
          ],
        ),
      );
      throw UnauthorizedRemoteException();
    } catch (error) {
      throw DioErrorMapper(
        errorResponseMapper ??
            BaseErrorResponseMapper.fromType(
              errorResponseMapperType ??
                  ResponseMapperConstants.defaultErrorResponseMapperType,
            ),
      ).map(error);
    }
  }
}
