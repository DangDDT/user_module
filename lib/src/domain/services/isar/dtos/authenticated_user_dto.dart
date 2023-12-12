// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';
import 'package:user_module/src/domain/exceptions/validation/validation_exception.dart';
import 'package:user_module/src/domain/models/app_user.dart';

part 'authenticated_user_dto.g.dart';

@collection
class AuthenticatedUserDTO {
  static const String nameSchema = 'authenticated_user_dto.schema';
  final Id id = Isar.autoIncrement;

  final String userId;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String avatar;

  @enumerated
  final Gender gender;
  final DateTime dob;
  final String address;
  @enumerated
  final Role role;

  final String token;
  final String refreshToken;
  final DateTime expiredAt;

  ///Extends
  final String? categoryId;
  final String? commissionId;

  AuthenticatedUserDTO({
    required this.userId,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.avatar,
    required this.gender,
    required this.dob,
    required this.address,
    required this.role,
    required this.token,
    required this.refreshToken,
    required this.expiredAt,
    this.categoryId,
    this.commissionId,
  });

  factory AuthenticatedUserDTO.fromAuthUser(AuthenticatedUser? appUser) {
    if (appUser == null) {
      throw ValidationException(
        ValidationExceptionKind.invalidInput,
        message: 'AuthenticatedUserDTO -> appUser must not be null',
      );
    }
    return AuthenticatedUserDTO(
      userId: appUser.user.id,
      fullName: appUser.user.fullName,
      phoneNumber: appUser.user.phoneNumber,
      email: appUser.user.email,
      address: appUser.user.address,
      avatar: appUser.user.avatar,
      dob: appUser.user.dob,
      gender: appUser.user.gender,
      role: appUser.user.role,
      token: appUser.token,
      refreshToken: appUser.refreshToken,
      expiredAt: appUser.expiredAt,
      categoryId: appUser.user.extraData['categoryId'],
      commissionId: appUser.user.extraData['commissionId'],
    );
  }

  AuthenticatedUser copyWithToken(String newToken) {
    return AuthenticatedUser(
      token: newToken,
      refreshToken: refreshToken,
      expiredAt: expiredAt,
      user: AppUserModel(
        id: userId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        address: address,
        avatar: avatar,
        gender: gender,
        dob: dob,
        role: role,
        extraData: {
          'categoryId': categoryId,
          'commissionId': commissionId,
        },
      ),
    );
  }

  AuthenticatedUser toAuthUser() {
    return AuthenticatedUser(
      token: token,
      refreshToken: refreshToken,
      expiredAt: expiredAt,
      user: AppUserModel(
        id: userId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        address: address,
        avatar: avatar,
        gender: gender,
        dob: dob,
        role: role,
        extraData: {
          'categoryId': categoryId,
          'commissionId': commissionId,
        },
      ),
    );
  }
}
