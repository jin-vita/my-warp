import 'package:flutter/material.dart';
import 'package:my_warp/page/home4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Image Warp',
      home: Home4(),
    );
  }
}
