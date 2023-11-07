import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_module/core/core.dart';
import 'package:user_module/core/utils/helpers/logger.dart';
import 'package:user_module/src/domain/requests/patch_account_profile_body.dart';
import 'package:user_module/src/domain/services/isar/daos/authenticated_user_dao.dart';
import 'package:user_module/src/domain/services/isar/dtos/authenticated_user_dto.dart';
import 'package:user_module/src/domain/services/user_service.dart';
import 'package:user_module/src/presentation/controllers/auth_controller.dart';
import 'package:user_module/src/presentation/widgets/gallery_picker.dart';

import '../../../domain/domain.dart';
import '../../../domain/services/file_service.dart';
import '../../shared/toast.dart';

class EditProfileController extends GetxController {
  ///AuthController
  final AuthController _authController =
      Get.find<AuthController>(tag: AuthController.tag);

  ///Services
  final AuthenticatedUserDAO _authDAO = Get.find<AuthenticatedUserDAO>(
    tag: AuthenticatedUserDAO.tag,
  );
  final UserService _userService = Get.find<UserService>();
  final FileService _fileService = Get.find<FileService>();

  AppUserModel? get currentUser => _authController.currentUser.value?.user;

  ///Controllers
  late final TextEditingController fullNameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController addressController;

  ///States
  late final Rx<Gender> gender = Rx(currentUser?.gender ?? Gender.male);
  late final Rxn<DateTime> dob;
  late final Rxn<File> updatingAvatar = Rxn<File>();
  late final RxBool isUpdatingAvatar = false.obs;
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

  Future<void> onChangeAvatar() async {
    final result = await GalleryManager.pickSingleImage();
    if (result == null || result.file == null) return;
    updatingAvatar.value = result.file;
    isUpdatingAvatar.value = true;
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
      String? updatedAvatar;
      if (updatingAvatar.value != null) {
        final avatarUrl = await _fileService.uploadFiles(
          files: [updatingAvatar.value!],
        );
        if (avatarUrl.isEmpty) {
          throw Exception(
            'Có lỗi xảy ra khi tải ảnh lên, vui lòng thử lại!',
          );
        }
        updatedAvatar = avatarUrl.first.link;
      }
      final AppUserModel updatedUser = AppUserModel(
        id: currentUser!.id,
        fullName: fullNameController.text,
        phoneNumber: phoneNumberController.text.toPhoneNumberStringFromFormat(),
        email: currentUser!.email,
        avatar: updatedAvatar ?? currentUser!.avatar,
        gender: gender.value,
        dob: dob.value!,
        address: addressController.text,
        role: currentUser!.role,
        extraData: currentUser!.extraData,
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

  Future<void> _callUpdateProfileApi(AppUserModel updatedUser) async {
    try {
      final result = await _userService.updateUserInfo(
        body: PatchAccountProfileBody(
          fullname: updatedUser.fullName,
          gender: updatedUser.gender.toStringKey(),
          phone: updatedUser.phoneNumber,
          dateOfBirth: updatedUser.dob,
          address: updatedUser.address,
          imageUrl: updatedUser.avatar,
        ),
      );
      if (result) {
        return;
      } else {
        throw Exception(
          'EditProfileController - _callUpdateProfileApi -> result is false',
        );
      }
    } catch (e) {
      rethrow;
    }
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
