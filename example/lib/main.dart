import 'package:flutter/material.dart';
import 'package:user_module/src/presentation/pages/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffFFB6C1)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
