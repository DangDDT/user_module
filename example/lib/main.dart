import 'package:example/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:user_module/core/core.dart';
import 'package:user_module/core/routes/middlewares/auth_middleware.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  await Isar.initializeIsarCore();
  await UserModule.init(
    baseUrlConfig: BaseUrlConfig(baseUrl: ''),
    homeRoute: Router.home,
    viewConfig: LoginViewConfig(
      appName: 'Blissfull Bells',
      isShowForgotPasswordButton: false,
      isShowRegisterButton: true,
    ),
    onRefreshTokenApiCallback: (refreshToken, accessToken) async {
      return null;
      // final dio = Dio(
      //   BaseOptions(
      //     baseUrl: '',
      //     sendTimeout: const Duration(seconds: 25),
      //     connectTimeout: const Duration(seconds: 25),
      //     receiveTimeout: const Duration(seconds: 25),
      //   ),
      // );
      // if (kDebugMode) {
      //   dio.interceptors.add(
      //     LogInterceptor(
      //       responseBody: true,
      //       requestBody: true,
      //     ),
      //   );
      // }
      // dio.options.headers['Authorization'] = 'Bearer $accessToken';
      // final response = await dio.post<dynamic>(
      //   '${''}/JwtAuth/api/mobile/ExtendToken',
      //   data: jsonEncode({
      //     'rtoken': refreshToken,
      //   }),
      // );
      // if (response.statusCode != 200) return null;
      // final userId = response.data['userId'] as int;
      // final expiredAt = response.data['expiredAt'] as DateTime;
      // final newAccessToken = response.data['accessToken'] as String;
      // final newRefreshToken = response.data['renewalToken'] as String;
      // final newAuthData = AuthenticatedUser(
      //   user: AppUser.mock(),
      //   token: newAccessToken,
      //   expiredAt: expiredAt,
      //   refreshToken: newRefreshToken,
      // );
      // return newAuthData;
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 240, 141, 71),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.arsenalTextTheme(),
      ),
      locale: const Locale('vi', 'VN'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', 'VN'),
        Locale('en', 'US'),
      ],
      initialRoute: Router.home,
      getPages: Router.routes,
    );
  }
}

class Router {
  static String home = '/home';

  static final List<GetPage> routes = <GetPage>[
    GetPage(
      name: home,
      page: () => const HomePage(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    ...UserModule.pageRoutes,
  ];
}
