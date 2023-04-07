import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_warp/util/my_painter4.dart';

class Home5 extends StatelessWidget {
  const Home5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String imagePath = 'assets/images/gmail.png';

    late ui.Image myImage;

    List<Offset> points = [
      const Offset(50, -100),
      const Offset(200, 400),
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
                painter: ImagePainter4(image: myImage, points: points),
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
