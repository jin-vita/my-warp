import 'package:flutter/material.dart';

import '../util/my_painter3.dart';

class Home4 extends StatefulWidget {
  const Home4({Key? key}) : super(key: key);

  @override
  State<Home4> createState() => _Home4State();
}

class _Home4State extends State<Home4> {
  final String imagePath = 'assets/images/gmail.png';
  final List<Offset> _points = [
    Offset.zero,
  ];
  final GlobalKey _imageKey = GlobalKey();

  void _onTapDown(BuildContext context, TapDownDetails details) {
    final RenderBox box = _imageKey.currentContext?.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      _points.add(localOffset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image with Points'),
      ),
      body: InkWell(
        onTapDown: (TapDownDetails details) => _onTapDown(context, details),
        child: Center(
          child: CustomPaint(
            key: _imageKey,
            painter: ImageWithPointsPainter(_points),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.5,
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
