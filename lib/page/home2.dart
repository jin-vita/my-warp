import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home2 extends StatelessWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String imagePath = 'assets/images/gmail.png';
    late ui.Image myImage;
    List<Offset> points = [];

    Future<ui.Image> loadImageFromAsset(String assetPath) async {
      final data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      return frame.image;
    }

    void setPoints() {
      // set 4 points here with x and y coordinates
      points.add(const Offset(0, 0));
      points.add(Offset(0, myImage.height.toDouble()));
      points.add(Offset(myImage.width.toDouble(), myImage.height.toDouble()));
      points.add(Offset(myImage.width.toDouble(), 0));
    }

    Matrix4 getTransform() {
      final matrix = Matrix4.identity();
      matrix.setValues(
        points[0].dx,
        points[0].dy,
        0,
        points[1].dx,
        points[1].dy,
        0,
        points[2].dx,
        points[2].dy,
        0,
        points[3].dx,
        points[3].dy,
        0,
        0,
        0,
        0,
        1,
      );
      final inverse = matrix.clone()..invert();
      final result = inverse.storage;
      result[12] = 0;
      result[13] = 0;

      return Matrix4.fromList(result);
    }

    return Scaffold(
      body: FutureBuilder(
        future: loadImageFromAsset(imagePath),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            myImage = snapshot.data!;
            setPoints();
            return Center(
              child: Stack(
                children: [
                  Transform(
                    transform: getTransform(),
                    child: const Image(
                      image: AssetImage(imagePath),
                    ),
                  ),
                  ...points.map((point) => Positioned(
                        left: point.dx,
                        top: point.dy,
                        child: Container(
                          width: 10,
                          height: 10,
                          color: Colors.red,
                        ),
                      ))
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
