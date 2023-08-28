import '../../../../../core/core.dart';
import '../dtos/authenticated_user_dto.dart';

abstract class AuthenticatedUserDAO {
  static const String tag = "${UserModule.packageName}_AuthenticatedUserDAO";

  Future<void> saveAppUser(AuthenticatedUserDTO appUserDTO);
  Future<AuthenticatedUserDTO?> getAppUser();
  Future<void> deleteAppUser();
  Future<AuthenticatedUserDTO?> updateAppUser(AuthenticatedUserDTO appUserDTO);
}
