import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:user_module/src/domain/entities/upload_result.dart';
import 'package:user_module/src/domain/models/upload_result_model.dart';

import 'dart:io';

import '../../domain/mappers/api_mappers/base/base_error_response_mapper.dart';
import '../../domain/mappers/api_mappers/base/base_success_response_mapper.dart';
import '../../domain/mappers/z_mapper.dart';
import '../../domain/services/file_service.dart';
import '../clients/base/dio_client.dart';
import '../clients/user_api_client.dart';

class FileRepository extends FileService {
  final UserApiClient _userApiClient = Get.find();
  final Mapper _mapper = Mapper.instance;
  final DioClient _dioClient = Get.find(tag: DioClient.tag);
  @override
  Future<List<UploadResultModel>> uploadFiles({
    required List<File> files,
  }) async {
    final List<dio.MultipartFile> multipartFiles = files.map((file) {
      final data = file.readAsBytesSync();
      final fileName = file.path.split('/').last;
      return dio.MultipartFile.fromBytes(
        data,
        filename: fileName,
      );
    }).toList();

    final response = await _dioClient.request<List<UploadResult>, UploadResult>(
      () => _userApiClient.uploadFiles(multipartFiles),
      decoder: (json) => UploadResult.fromMap(json),
      successResponseMapperType: SuccessResponseMapperType.jsonArray,
      errorResponseMapperType: ErrorResponseMapperType.jsonObject,
    );
    return _mapper.mapListData<UploadResult, UploadResultModel>(response);
  }
}
