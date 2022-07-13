import 'package:flutter/material.dart';

abstract class MyStyle {
  static var title =
      TextStyle(color: Colors.red.shade600, fontSize: 23, shadows: [
    for (double i = 1; i < 3; i++)
      Shadow(color: const Color.fromARGB(255, 114, 66, 66), blurRadius: 3 * i)
  ]);
  static var subTitle = TextStyle(color: Colors.white, fontSize: 15, shadows: [
    for (double i = 1; i < 4; i++) Shadow(color: Colors.red, blurRadius: 3 * i)
  ]);
  //static var offTitle = TextStyle(color: Colors.grey, fontSize: 30);
  static const state =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500);
}
