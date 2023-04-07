import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ImageTransformPainter extends CustomPainter {
  ui.Image image;
  List<Offset> points;

  ImageTransformPainter(this.image, this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high;

    // Draw original image
    // canvas.drawImage(image, Offset.zero, paint);

    // Draw points
    paint.color = Colors.red;
    paint.strokeWidth = 5;
    for (Offset point in points) {
      canvas.drawCircle(point, 10, paint);
    }

    // Draw transformed image
    Path path = Path()
      ..moveTo(points[0].dx, points[0].dy)
      ..lineTo(points[1].dx, points[1].dy)
      ..lineTo(points[2].dx, points[2].dy)
      ..lineTo(points[3].dx, points[3].dy)
      ..close();
    canvas.clipPath(path);

    Rect rect = Rect.fromLTRB(points[0].dx, points[0].dy, points[2].dx, points[2].dy);
    Offset center = rect.center;
    double scale = rect.width / image.width;
    double radians = 0;
    double offsetX = 0;
    double offsetY = 0;

    canvas.translate(center.dx, center.dy);
    canvas.rotate(radians);
    canvas.scale(scale, scale);
    canvas.translate(-center.dx + offsetX, -center.dy + offsetY);

    canvas.drawImage(image, Offset.zero, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
