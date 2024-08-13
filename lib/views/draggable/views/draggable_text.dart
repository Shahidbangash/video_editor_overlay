import 'package:flutter/material.dart';

class DraggableText extends StatefulWidget {
  const DraggableText({super.key});

  @override
  State<DraggableText> createState() => _DraggableTextState();
}

class _DraggableTextState extends State<DraggableText> {
  Offset offset = const Offset(100, 100);
  double textSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: offset.dx,
            top: offset.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  offset = Offset(offset.dx + details.delta.dx,
                      offset.dy + details.delta.dy);
                });
              },
              // onScaleUpdate: (details) {
              //   setState(() {
              //     textSize = 20.0 * details.scale;
              //   });
              // },
              child: Text(
                'Draggable Text',
                style: TextStyle(fontSize: textSize, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
