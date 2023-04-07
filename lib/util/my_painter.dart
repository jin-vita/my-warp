import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ImagePainter extends CustomPainter {
  ui.Image image;
  List<Offset> points = [];

  ImagePainter(this.image) {
    // 이미지의 중심점 계산
    Offset center = Offset(image.width / 2, image.height / 2);

    // 이미지 위에 점 4개 찍기
    points.add(center.translate(-100, -50));
    points.add(center.translate(50, 0));
    points.add(center.translate(-50, 50));
    points.add(center.translate(50, 50));
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 이미지의 변형 계산
    Matrix4 matrix = Matrix4.identity();
    matrix.setValues(
      points[0].dx,
      points[0].dy,
      0,
      0,
      points[1].dx,
      points[1].dy,
      0,
      0,
      points[2].dx,
      points[2].dy,
      0,
      0,
      points[3].dx,
      points[3].dy,
      0,
      0,
    );

    // 이미지 변형 적용
    canvas.save();
    canvas.transform(matrix.storage);
    canvas.drawImage(image, Offset.zero, Paint());
    canvas.restore();

    // 점 그리기
    for (var point in points) {
      canvas.drawCircle(point, 5, Paint()..color = Colors.red);
    }
  }

  @override
  bool shouldRepaint(ImagePainter oldDelegate) {
    return true;
  }
}
