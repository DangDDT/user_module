import 'package:isar/isar.dart';
import 'package:user_module/src/domain/services/isar/daos/authenticated_user_dao.dart';
import 'package:user_module/src/domain/services/isar/dtos/authenticated_user_dto.dart';

import 'isar_database.dart';

class AuthenticatedUserDAOImpl implements AuthenticatedUserDAO {
  final Isar _isar = IsarDatabase.instance.database;

  @override
  Future<void> deleteAppUser() async {
    await _isar.writeTxn(() async {
      await _isar.authenticatedUserDTOs.where().deleteAll();
    });
  }

  @override
  Future<AuthenticatedUserDTO?> getAppUser() async {
    final result = await _isar.authenticatedUserDTOs.where().findFirst();
    return result;
  }

  @override
  Future<void> saveAppUser(AuthenticatedUserDTO appUserDTO) async {
    await _isar.writeTxn(() async {
      await _isar.authenticatedUserDTOs.put(appUserDTO);
    });
  }

  @override
  Future<AuthenticatedUserDTO?> updateAppUser(AuthenticatedUserDTO appUserDTO) {
    return _isar.writeTxn(() async {
      final deleted = await _isar.authenticatedUserDTOs
          .filter()
          .userIdEqualTo(
            appUserDTO.userId,
          )
          .deleteFirst();
      if (deleted) {
        await _isar.authenticatedUserDTOs.put(appUserDTO);
        final updatedResult =
            await _isar.authenticatedUserDTOs.where().findFirst();
        return updatedResult;
      }
      return null;
    });
  }
}
