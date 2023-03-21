import 'package:flutter/material.dart';
import 'package:wallpaper_hub/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WallPaper',
      theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.white)),
      home: const Home(),
    );
  }
}
