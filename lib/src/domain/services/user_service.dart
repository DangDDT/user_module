import 'package:user_module/core/core.dart';

abstract class UserService {
  Future<AppUserModel> getUserInfo({
    required String token,
  });
}
