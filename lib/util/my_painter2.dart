import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ImagePainter2 extends CustomPainter {
  final ui.Image image;
  final List<Offset> points;

  ImagePainter2(this.image, this.points);

  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
