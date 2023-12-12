// // ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'user_module.dart';

class ModuleConfig {
  static const String tag = '${UserModule.packageName}_ModuleConfig';
  ModuleConfig({
    this.isShowLog = false,
    this.mockConfig,
    required this.baseUrlConfig,
    this.loginViewConfig,
    required this.homeRoute,
    this.onGetFirebaseToken,
    this.onRefreshTokenCallback,
  })
  // :
  // _userConfig = null,
  //       _authConfig = null
  ;

  final bool isShowLog;

  final MockConfig? mockConfig;

  final BaseUrlConfig baseUrlConfig;

  final LoginViewConfig? loginViewConfig;

  final OnGetFirebaseToken? onGetFirebaseToken;

  final OnRefreshTokenCallback? onRefreshTokenCallback;

  // UserConfig? _userConfig;

  // UserConfig get userConfig {
  //   if (_userConfig == null) {
  //     throw AssertionError("Bạn chưa đăng nhập để sử dụng chức năng này");
  //   }

  //   return _userConfig!;
  // }

  // set setUserConfig(UserConfig? userConfig) {
  //   _userConfig = userConfig;
  // }

  // ///[authConfig] là các config về auth của module
  // ///[authConfig] là config để authen/authorize cho module
  // AuthConfig? _authConfig;
  // AuthConfig? get getAuthConfig => _authConfig;
  // set setAuthConfig(AuthConfig? authConfig) => _authConfig = authConfig;

  // ModuleRole? _moduleRole;
  // ModuleRole get moduleRole {
  //   if (_moduleRole == null) {
  //     throw AssertionError("Bạn không có quyền để sử dụng chức năng này");
  //   }

  //   return _moduleRole!;
  // }

  // set setModuleRole(ModuleRole? moduleRole) => _moduleRole = moduleRole;

  String homeRoute;
}

class BaseUrlConfig {
  final String baseUrl;

  BaseUrlConfig({
    required this.baseUrl,
  });
}

class LoginViewConfig {
  final String? imageBackground;
  final Widget? logo;
  final String appName;
  final bool isShowRegisterButton;
  final bool isShowForgotPasswordButton;

  LoginViewConfig({
    this.imageBackground,
    this.logo,
    required this.appName,
    this.isShowRegisterButton = true,
    this.isShowForgotPasswordButton = true,
  });
}

class UserConfig {
  final int userId;
  const UserConfig({
    required this.userId,
  });
}

class MockConfig {
  final Role role;
  const MockConfig({
    required this.role,
  });
}

class AuthConfig {
  /// TODO: Thêm các trường dữ liệu cần thiết để thực hiện các chức năng cho module

  /// [accessToken] là callback được gọi để truyền accesstoken vào header của api
  final OnGetFirebaseToken accessToken;

  /// [onRefreshTokenCallback] là callback được gọi khi có lỗi xảy ra với api
  final OnRefreshTokenCallback onRefreshTokenCallback;
  AuthConfig({
    required this.accessToken,
    required this.onRefreshTokenCallback,
  });
}

typedef OnGetFirebaseToken = Future<String?> Function(
  String email,
  String password,
);
typedef OnRefreshTokenCallback = Future<String?> Function();
