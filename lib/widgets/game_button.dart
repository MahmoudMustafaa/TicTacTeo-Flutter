import 'package:flutter/material.dart';

class GameButton {
  final int id;
  String text;
  Color bg;
  bool enabled;
  TextStyle textStyle;
  BoxDecoration decoration;

  GameButton({
    required this.id,
    this.text = "",
    this.bg = Colors.transparent,
    this.enabled = true,
  })  : textStyle = const TextStyle(
          color: Colors.white,
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
        decoration = BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        );
}
