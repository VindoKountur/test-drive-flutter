import 'package:flutter/material.dart';
import 'package:test_drive/container_page.dart';
import 'package:test_drive/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
      // home: ContainerPage(),
    );
  }
}
