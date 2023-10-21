import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_module/core/core.dart';
import 'package:user_module/core/utils/helpers/logger.dart';
import 'package:user_module/src/domain/services/isar/daos/authenticated_user_dao.dart';
import 'package:user_module/src/domain/services/isar/dtos/authenticated_user_dto.dart';
import 'package:user_module/src/presentation/controllers/auth_controller.dart';

import '../../../domain/domain.dart';
import '../../shared/toast.dart';

class EditProfileController extends GetxController {
  ///AuthController
  final AuthController _authController =
      Get.find<AuthController>(tag: AuthController.tag);

  ///Services
  final AuthenticatedUserDAO _authDAO = Get.find<AuthenticatedUserDAO>(
    tag: AuthenticatedUserDAO.tag,
  );

  AppUserModel? get currentUser => _authController.currentUser.value?.user;

  ///Controllers
  late final TextEditingController fullNameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController addressController;

  ///States
  late final Rx<Gender> gender = Rx(currentUser?.gender ?? Gender.male);
  late final Rxn<DateTime> dob;
  final RxBool isSaveLoading = false.obs;

  @override
  void onInit() {
    fullNameController = TextEditingController(text: currentUser?.fullName);
    phoneNumberController =
        TextEditingController(text: currentUser?.phoneNumber.toPhoneNumber());
    dob = Rxn(currentUser?.dob);
    addressController = TextEditingController(text: currentUser?.address);
    super.onInit();
  }

  void onChangeGender(Gender? value) {
    if (value == null) return;
    gender.value = value;
  }

  Future<void> onChangeDOB() async {
    final DateTime? selection = await Get.dialog<DateTime?>(
      DatePickerDialog(
        initialDate: dob.value ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      ),
    );
    if (selection != null) {
      dob.value = selection;
    }
  }

  Future<void> onSave() async {
    isSaveLoading.value = true;
    try {
      final AuthenticatedUser? currentAuthUser =
          _authController.currentUser.value;
      if (currentUser == null || dob.value == null || currentAuthUser == null) {
        throw ValidationException(
          ValidationExceptionKind.invalidInput,
        );
      }

      final AppUserModel updatedUser = AppUserModel(
        id: currentUser!.id,
        fullName: fullNameController.text,
        phoneNumber: phoneNumberController.text.toPhoneNumberStringFromFormat(),
        email: currentUser!.email,
        avatar: currentUser!.avatar,
        gender: gender.value,
        dob: dob.value!,
        address: addressController.text,
        role: currentUser!.role,
      );
      await _callUpdateProfileApi.call(updatedUser);
      await _saveNewProfileToLocal.call(currentAuthUser, updatedUser);
      await _changeCurrentUser.call(updatedUser);
      Get.back();
      Toast.showSuccess(
        title: 'Cập nhật thành công',
        message: 'Thông tin của bạn đã được cập nhật',
      );
    } catch (e, stackTrace) {
      Logger.log(
        e.toString(),
        name: 'EditProfileController - onSave',
        stackTrace: stackTrace,
      );
      Toast.showError(
        title: 'Cập nhật thất bại',
        message: 'Đã có lỗi xảy ra, vui lòng thử lại!',
      );
    }
    isSaveLoading.value = false;
  }

  Future<void> _callUpdateProfileApi(AppUserModel appUser) async {
    //TODO: Call api update profile
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> _saveNewProfileToLocal(
      AuthenticatedUser currentUser, AppUserModel appUser) async {
    final AuthenticatedUser updatedUser = AuthenticatedUser(
      token: currentUser.token,
      refreshToken: currentUser.refreshToken,
      expiredAt: currentUser.expiredAt,
      user: appUser,
    );
    final AuthenticatedUserDTO updatedUserDTO =
        AuthenticatedUserDTO.fromAuthUser(updatedUser);
    await _authDAO.updateAppUser(updatedUserDTO);
  }

  Future<void> _changeCurrentUser(AppUserModel appUser) async {
    final AuthenticatedUser? currentUser = _authController.currentUser.value;
    if (currentUser == null) {
      throw ValidationException(
        ValidationExceptionKind.invalidInput,
        message:
            'EditProfileController - _changeCurrentUser -> currentUser must not be null',
      );
    }
    final AuthenticatedUser updatedUser = AuthenticatedUser(
      token: currentUser.token,
      refreshToken: currentUser.refreshToken,
      expiredAt: currentUser.expiredAt,
      user: appUser,
    );
    _authController.onChangeCurrentUser(updatedUser);
  }
}
