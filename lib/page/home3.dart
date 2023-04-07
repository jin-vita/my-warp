import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_warp/util/my_painter2.dart';

class Home3 extends StatelessWidget {
  const Home3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String imagePath = 'assets/images/gmail.png';

    late ui.Image myImage;

    List<Offset> points = [
      const Offset(0, 50),
      const Offset(220, 110),
      const Offset(200, 200),
      const Offset(50, 200),
    ];

    Future<ui.Image> loadImageFromAsset(String assetPath) async {
      final ByteData data = await rootBundle.load(assetPath);
      final Uint8List bytes = data.buffer.asUint8List();
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo frame = await codec.getNextFrame();
      return frame.image;
    }

    return Scaffold(
      body: FutureBuilder(
        future: loadImageFromAsset(imagePath),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            myImage = snapshot.data!;
            return Center(
              child: CustomPaint(
                painter: ImageTransformPainter(myImage, points),
                size: Size(myImage.width.toDouble(), myImage.height.toDouble()),
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
