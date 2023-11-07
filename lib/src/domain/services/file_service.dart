import 'dart:io';

import '../models/upload_result_model.dart';

abstract class FileService {
  Future<List<UploadResultModel>> uploadFiles({
    required List<File> files,
  });
}
