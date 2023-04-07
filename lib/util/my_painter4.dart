import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImagePainter4 extends CustomPainter {
  final ui.Image image;
  final List<Offset> points;

  ImagePainter4({required this.image, required this.points});

  @override
  void paint(Canvas canvas, Size size) async {
    final src = const Offset(0, 0) & Size(image.width.toDouble(), image.height.toDouble());
    final dst = getDestinationRect(points);

    canvas.drawImageRect(image, src, dst, Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  Future<ui.Image> loadImage(String imagePath) async {
    final data = await rootBundle.load(imagePath);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Rect getDestinationRect(List<Offset> points) {
    final left = points.map((p) => p.dx).reduce((value, element) => value < element ? value : element);
    final top = points.map((p) => p.dy).reduce((value, element) => value < element ? value : element);
    final right = points.map((p) => p.dx).reduce((value, element) => value > element ? value : element);
    final bottom = points.map((p) => p.dy).reduce((value, element) => value > element ? value : element);
    return Offset(left, top) & Size(right - left, bottom - top);
  }
}
