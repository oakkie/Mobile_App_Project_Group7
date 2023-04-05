import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import './app_screen/diaryFix.dart';
import 'app_screen/intro.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreen(),
      theme: ThemeData(primarySwatch: Colors.brown),
      debugShowCheckedModeBanner: false,
    );
  }
}
