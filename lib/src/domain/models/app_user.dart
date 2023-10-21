// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:user_module/core/core.dart';

class AppUserModel {
  final dynamic id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String avatar;
  final Gender gender;
  final DateTime dob;
  final String address;
  final Role role;
  AppUserModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.avatar,
    required this.gender,
    required this.dob,
    required this.address,
    required this.role,
  });

  factory AppUserModel.mock() {
    final ModuleConfig moduleConfig = Get.find(tag: ModuleConfig.tag);
    final faker = Faker();
    return AppUserModel(
      id: faker.guid.guid(),
      fullName: faker.person.name(),
      phoneNumber: '0774839222',
      email: faker.internet.email(),
      address: faker.address.streetAddress(),
      avatar: faker.image.image(),
      gender: Gender.male,
      dob: DateTime(2000, 1, 1),
      role: moduleConfig.mockConfig?.role ?? Role.customer,
    );
  }
}

enum Gender {
  male('Nam'),
  female('Nữ'),
  other('Khác');

  final String name;

  const Gender(this.name);

  bool get isMale => this == male;

  bool get isFemale => this == female;

  bool get isOther => this == other;
}

enum Role {
  customer('CUSTOMER'),
  partner('PARTNER'),
  staff('STAFF');

  final String name;

  const Role(this.name);

  static Role fromString(String? value) {
    switch (value) {
      case 'Customer':
        return Role.customer;
      case 'Partner':
        return Role.partner;
      case 'Staff':
        return Role.staff;
      default:
        return throw Exception('Role not found');
    }
  }
}

class AuthenticatedUser {
  final String token;
  final String refreshToken;
  final DateTime expiredAt;
  final AppUserModel user;

  AuthenticatedUser({
    required this.token,
    required this.refreshToken,
    required this.expiredAt,
    required this.user,
  });

  factory AuthenticatedUser.mock() {
    final faker = Faker();
    return AuthenticatedUser(
      token: faker.guid.guid(),
      refreshToken: faker.guid.guid(),
      expiredAt: DateTime.now().add(const Duration(days: 1)),
      user: AppUserModel.mock(),
    );
  }
}
