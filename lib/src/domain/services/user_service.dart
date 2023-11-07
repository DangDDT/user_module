import 'package:user_module/core/core.dart';
import 'package:user_module/src/domain/requests/patch_account_profile_body.dart';

abstract class UserService {
  Future<AppUserModel> getUserInfo({
    required String token,
  });

  Future<bool> updateUserInfo({
    required PatchAccountProfileBody body,
  });
}
