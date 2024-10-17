import 'package:flutter/material.dart';
import 'package:gaming/pages/market_page.dart';
import 'package:gaming/pages/single_player__page.dart';
import 'package:gaming/pages/selectgame.dart';
import 'package:gaming/pages/welcom_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
