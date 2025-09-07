import 'package:breeziai/utils/colours.dart';
import 'package:breeziai/views/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BreeziAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: MyColours.background,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
