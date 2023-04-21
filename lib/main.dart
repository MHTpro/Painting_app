import 'package:flutter/material.dart';
import './draw_screen.dart';

void main() => runApp(const DrawApp());

class DrawApp extends StatelessWidget {
  const DrawApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Draw(),
    );
  }
}
