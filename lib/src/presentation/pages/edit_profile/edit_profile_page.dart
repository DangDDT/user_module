import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:user_module/core/core.dart';
import 'package:user_module/core/utils/formatters/phone_number_formatter.dart';
import 'package:user_module/src/presentation/shared/fade_transition_wrapper.dart';
import 'package:user_module/src/presentation/shared/shared.dart';
import 'package:user_module/src/presentation/widgets/custom_text_field.dart';
import 'package:user_module/src/presentation/widgets/responsive_width.dart';

import '../../shared/unauthenticated_widget.dart';
import '../../widgets/loading_button.dart';
import '../../widgets/title_wrapper.dart';
import 'edit_profile_controller.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chỉnh sửa thông tin'),
        ),
        body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kGapH24,
              Center(
                child: FadeTransitionWrapper(
                  child: _AvatarBuilder(),
                ),
              ),
              kGapH12,
              FadeTransitionWrapper(child: _EditProfileForm()),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarBuilder extends GetView<EditProfileController> {
  const _AvatarBuilder();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.updatingAvatar.value != null) {
        return _UserAvatar.localFile(
          localFileToUpdate: controller.updatingAvatar.value,
          fullName: '',
        );
      } else {
        return _UserAvatar(
          avatarUrl: controller.currentUser?.avatar,
          fullName: controller.currentUser!.fullName,
        );
      }
    });
  }
}

class _UserAvatar extends GetView<EditProfileController> {
  final String? avatarUrl;
  final String fullName;
  final File? localFileToUpdate;
  const _UserAvatar({
    required this.avatarUrl,
    required this.fullName,
  }) : localFileToUpdate = null;
  const _UserAvatar.localFile({
    required this.localFileToUpdate,
    required this.fullName,
  }) : avatarUrl = null;

  @override
  Widget build(BuildContext context) {
    final imageProvider = localFileToUpdate != null
        ? BaseExtendedImageFile(file: localFileToUpdate!)
        : avatarUrl != null
            ? BaseExtendedImageNetwork(imageUrl: avatarUrl!)
            : null;
    final circleAvatar = localFileToUpdate != null
        ? CircleAvatarWithErrorHandler.file(
            radius: 64,
            file: localFileToUpdate!,
            fullName: fullName,
          )
        : CircleAvatarWithErrorHandler(
            avatarUrl: avatarUrl,
            fullName: fullName,
            radius: 64,
          );
    const double radius = 64;
    return AuthViewBuilderWrapper(
      onAuthenticated: (user) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        height: 175,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider!.image,
            fit: BoxFit.cover,
            opacity: .2,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: kTheme.colorScheme.primary.withOpacity(.2),
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: kTheme.colorScheme.onBackground.withOpacity(.5),
                blurRadius: 25,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: _EditAvatarWrapper(
            child: circleAvatar,
          ),
        ),
      ),
      onUnAuthenticated: () => const CircleAvatar(),
    );
  }
}

class _EditAvatarWrapper extends GetView<EditProfileController> {
  final Widget child;
  const _EditAvatarWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          bottom: -5,
          right: -5,
          child: IconButton.filledTonal(
            onPressed: controller.onChangeAvatar,
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ),
      ],
    );
  }
}

class _EditProfileForm extends StatelessWidget {
  const _EditProfileForm();

  @override
  Widget build(BuildContext context) {
    return AuthViewBuilderWrapper(
      onAuthenticated: (user) => const ResponsiveWidthWrapper(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            children: [
              _EditGender(),
              kGapH4,
              _EditFullName(),
              kGapH4,
              _EditPhoneNumber(),
              kGapH4,
              _EditDOB(),
              kGapH4,
              _EditAddress(),
              kGapH24,
              _SaveEditButton(),
            ],
          ),
        ),
      ),
      onUnAuthenticated: () => const UnauthenticatedWidget(),
    );
  }
}

class _EditGender extends GetView<EditProfileController> {
  const _EditGender();

  @override
  Widget build(BuildContext context) {
    return TitleWrapper(
      title: 'Giới tính (*)',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...Gender.values
              .map(
                (gender) => Flexible(
                  child: Obx(
                    () {
                      final isSelected = controller.gender.value == gender;
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 210),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: RadioListTile<Gender>(
                          key: ValueKey('${gender}_$isSelected'),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          visualDensity: VisualDensity.compact,
                          value: gender,
                          selected: isSelected,
                          selectedTileColor:
                              kTheme.colorScheme.primary.withOpacity(.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: isSelected
                                ? const BorderSide(
                                    color: Colors.transparent,
                                  )
                                : BorderSide(
                                    color: kTheme.colorScheme.onBackground
                                        .withOpacity(.2),
                                  ),
                          ),
                          title: Text(
                            gender.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: isSelected
                                      ? kTheme.colorScheme.primary
                                      : kTheme.colorScheme.onBackground
                                          .withOpacity(.6),
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          groupValue: controller.gender.value,
                          onChanged: controller.onChangeGender,
                        ),
                      );
                    },
                  ),
                ),
              )
              .toList()
              .joinWidget(kGapW4),
        ],
      ),
    );
  }
}

class _EditFullName extends GetView<EditProfileController> {
  const _EditFullName();

  @override
  Widget build(BuildContext context) {
    return TitleWrapper(
      title: 'Họ và tên (*)',
      child: CustomTextField(
        labelText: 'Họ và tên',
        controller: controller.fullNameController,
      ),
    );
  }
}

class _EditPhoneNumber extends GetView<EditProfileController> {
  const _EditPhoneNumber();

  @override
  Widget build(BuildContext context) {
    return TitleWrapper(
      title: 'Số điện thoại (*)',
      child: CustomTextField(
        labelText: 'Số điện thoại',
        controller: controller.phoneNumberController,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          PhoneNumberFormatter(),
        ],
      ),
    );
  }
}

class _EditDOB extends GetView<EditProfileController> {
  const _EditDOB();

  @override
  Widget build(BuildContext context) {
    return TitleWrapper(
      title: 'Ngày sinh (*)',
      child: Obx(
        () => CustomTextField(
          labelText: "Ngày sinh",
          onTap: controller.onChangeDOB,
          controller: TextEditingController(
            text: controller.dob.value?.toDateReadable(),
          ),
          readOnly: true,
          suffixIcon: const Icon(
            Icons.calendar_today,
            color: Colors.grey,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _EditAddress extends GetView<EditProfileController> {
  const _EditAddress();

  @override
  Widget build(BuildContext context) {
    return TitleWrapper(
      title: 'Địa chỉ (*)',
      child: CustomTextField(
        labelText: 'Địa chỉ',
        controller: controller.addressController,
      ),
    );
  }
}

class _SaveEditButton extends GetView<EditProfileController> {
  const _SaveEditButton();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: controller.isSaveLoading.value ? null : controller.onSave,
        child: LoadingButton(
          isLoading: controller.isSaveLoading.value,
          label: 'Lưu thay đổi',
        ),
      ),
    );
  }
}
