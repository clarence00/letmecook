import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letmecook/pages/login_page.dart';
import 'package:letmecook/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return const MaterialApp(
      title: 'Let Me Cook',
      home: LoginPage(),
    );
  }
}
