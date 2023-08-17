// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import '../src/domain/domain.dart';
import '../src/infrastructure/infrastructure.dart';
import 'module_configs.dart';
import 'user_module.dart';

class GlobalBinding {
  static void setUpLocator({
    required bool isShowLog,
    required BaseUrlConfig baseUrlConfig,
    ViewConfig? viewConfig,
  }) {
    Get.lazyPut<ModuleConfig>(
      () => ModuleConfig(
        isShowLog: isShowLog,
        baseUrlConfig: baseUrlConfig,
        viewConfig: viewConfig,
      ),
      fenix: true,
      tag: ModuleConfig.tag,
    );

    Mapper.instance.registerMappers([]);

    final dioClient = Get.put<DioClient>(
      DioClient(
        baseUrl: baseUrlConfig.baseUrl,
      ),
      tag: DioClient.tag,
    );

    ///TODO: ApiClient

    Get.put<GlobalController>(
      GlobalController(),
      permanent: true,
      tag: GlobalController.tag,
    );
  }
}

class GlobalController extends GetxController {
  static const String tag = "${UserModule.packageName}|GLOBAL_CONTROLLER";

  ///Services

  // final Rx<StateDataVM<List<DMBankModel>>> _listDMBank =
  //     Rx(StateDataVM.none<DMBankModel>(List));
  // Rx<StateDataVM<List<DMBankModel>>> get listDMBank => _listDMBank;

  // Future<void> loadDMBank() async {
  //   _listDMBank.value = _listDMBank.value.setLoading();
  //   try {
  //     final result = await _danhMucServices.getDanhMucBanks();
  //     if (result.isNotEmpty) {
  //       _listDMBank.value = _listDMBank.value.setSuccess(result);
  //     } else {
  //       _listDMBank.value = _listDMBank.value.setError("Không có dữ liệu");
  //     }
  //     update();
  //   } catch (e, stackTrace) {
  //     _listDMBank.value = _listDMBank.value.setError(e.toString());
  //     Logger.logError(e.toString(),
  //         name: "GlobalController_loadDMBank()", stackTrace: stackTrace);
  //   }
  // }
}
