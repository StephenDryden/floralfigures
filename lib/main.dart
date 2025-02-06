import 'package:floralfigures/pages/home_page.dart';
import 'package:floralfigures/themes/color.dart';
import 'package:floralfigures/themes/text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        textTheme: textTheme,
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor:
            const Color.fromARGB(255, 244, 221, 229), // background color
      ),
    );
  }
}
