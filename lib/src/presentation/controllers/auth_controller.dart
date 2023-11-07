import 'package:get/get.dart';
import 'package:user_module/core/utils/helpers/logger.dart';
import 'package:user_module/src/domain/domain.dart';
import 'package:user_module/src/domain/services/isar/daos/authenticated_user_dao.dart';
import 'package:user_module/src/domain/services/user_service.dart';

import '../../../core/core.dart';
import '../../../core/typedefs/auth_listener.dart';
import '../../domain/services/isar/dtos/authenticated_user_dto.dart';

class AuthController extends GetxController with AuthListenerMixins {
  static const String tag = "${UserModule.packageName}_AuthController";

  ///Services
  final AuthenticatedUserDAO _authDAO = Get.find<AuthenticatedUserDAO>(
    tag: AuthenticatedUserDAO.tag,
  );
  final UserService _userService = Get.find();

  final ModuleConfig _moduleConfig =
      Get.find<ModuleConfig>(tag: ModuleConfig.tag);

  ///State
  final Rx<AuthState> _authState =
      AuthState(AuthStateEnum.unthenticated, null).obs;
  Rx<AuthState> get authState => _authState;

  @override
  onInit() {
    _addListeners();
    _onChangeAuthState();
    super.onInit();
  }

  Future<AuthenticatedUser?> getUser({
    required String? token,
  }) async {
    try {
      if (token == null) {
        final localUser = await _getUserLocal();
        if (localUser == null) {
          return null;
        }
        final user = await _userService.getUserInfo(
          token: localUser.token,
        );

        final newAuth = AuthenticatedUser(
          expiredAt: DateTime(2100),
          refreshToken: '',
          token: localUser.token,
          user: user,
        );
        await _authDAO.updateAppUser(
          AuthenticatedUserDTO.fromAuthUser(newAuth),
        );
        return newAuth;
      } else {
        final user = await _userService.getUserInfo(
          token: token,
        );
        return AuthenticatedUser(
          expiredAt: DateTime(2100),
          refreshToken: '',
          token: token,
          user: user,
        );
      }
    } on UnauthorizedRemoteException {
      await logout();
      return null;
    } catch (e, stackTrace) {
      Logger.log(
        e.toString(),
        name: 'AuthController - getUserApi',
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<AuthenticatedUser?> _getUserLocal() async {
    final AuthenticatedUserDTO? authenticatedUserDTO =
        await _authDAO.getAppUser();
    final AuthenticatedUser? authUser = authenticatedUserDTO?.toAuthUser();
    return authUser;
  }

  Future<void> login(AuthenticatedUser user) async {
    await _authDAO.saveAppUser(
      AuthenticatedUserDTO.fromAuthUser(user),
    );
    await _onChangeAuthState();
  }

  Future<void> logout() async {
    await _authDAO.deleteAppUser();
    await _onChangeAuthState();
  }

  Future<void> _onChangeAuthState() async {
    final AuthenticatedUser? authUser = await getUser(
      token: null,
    );
    if (authUser == null) {
      _authState.value = UnthenticatedState();
      Get.offAllNamed(RouteConstants.loginRoute);
    } else {
      _authState.value = AuthenticatedState(authUser);
      Get.offAllNamed(_moduleConfig.homeRoute);
    }
  }

  void _addListeners() {
    ever(authState, (state) {
      _notifyListeners(state);
      _previousAuthenticationState = state;
    });
  }

  String? get accessToken => _authState.value.isAuthenticated
      ? (_authState.value as AuthenticatedState).user.token
      : null;

  Rxn<AuthenticatedUser> get currentUser => _authState.value.isAuthenticated
      ? Rxn<AuthenticatedUser>((_authState.value as AuthenticatedState).user)
      : Rxn<AuthenticatedUser>(null);

  void onChangeCurrentUser(AuthenticatedUser? user) {
    if (user == null) {
      _authState.value = UnthenticatedState();
    } else {
      _authState.value = AuthenticatedState(user);
    }
  }
}

mixin AuthListenerMixins on GetxController {
  // ignore: prefer_final_fields
  AuthState _previousAuthenticationState = UnthenticatedState();

  final List<AuthListener> _listeners = [];

  void addAuthStateListener(AuthListener listener) {
    _listeners.add(listener);
  }

  void removeAuthStateListener(AuthListener listener) {
    _listeners.remove(listener);
  }

  // ignore: unused_element
  void _notifyListeners(AuthState state) {
    final previousState = _previousAuthenticationState;
    for (var listener in _listeners) {
      listener(previousState, state);
    }
  }
}

enum AuthStateEnum {
  authenticated,
  unthenticated;

  bool get isAuthenticated => this == AuthStateEnum.authenticated;

  bool get isUnthenticated => this == AuthStateEnum.unthenticated;
}

class AuthState {
  final AuthStateEnum state;
  final AuthenticatedUser? user;
  AuthState(this.state, this.user);

  bool get isAuthenticated => state.isAuthenticated;

  bool get isUnthenticated => state.isUnthenticated;
}

class AuthenticatedState extends AuthState {
  @override
  final AuthenticatedUser user;

  AuthenticatedState(this.user) : super(AuthStateEnum.authenticated, user);
}

class UnthenticatedState extends AuthState {
  UnthenticatedState() : super(AuthStateEnum.unthenticated, null);
}
