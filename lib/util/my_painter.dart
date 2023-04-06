import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final ui.Image image;
  final List<Offset> points;

  MyPainter(this.image, this.points);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, Offset.zero, Paint());

    final paint = Paint()..color = Colors.red;
    for (var i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i] * size.width, 10, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
