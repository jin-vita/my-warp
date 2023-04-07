import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_warp/util/my_painter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String imagePath = 'assets/images/gmail.png';

    return Scaffold(
      appBar: AppBar(
        title: const Text('warp image'),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image(
              image: AssetImage(imagePath),
            ),
          ),
          FutureBuilder(
            future: loadImageFromAsset(imagePath),
            builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
              if (snapshot.hasData) {
                return CustomPaint(
                  painter: ImagePainter(snapshot.data!),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<ui.Image> loadImageFromAsset(String path) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}
