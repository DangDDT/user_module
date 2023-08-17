import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_module/core/core.dart';
import 'package:user_module/src/presentation/pages/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffCC8B82)),
        useMaterial3: true,
        textTheme: GoogleFonts.arsenalTextTheme(),
      ),
      home: const LoginPage(),
      onInit: () {
        UserModule.init(
          baseUrlConfig: BaseUrlConfig(baseUrl: ''),
        );
      },
    );
  }
}
