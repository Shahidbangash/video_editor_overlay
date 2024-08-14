import 'package:flutter/material.dart';

class DraggableText extends StatefulWidget {
  const DraggableText({super.key});

  @override
  State<DraggableText> createState() => _DraggableTextState();
}

class _DraggableTextState extends State<DraggableText> {
  Offset offset = const Offset(100, 100);
  double textSize = 20.0;
  bool isEditing = false;
  String text = 'Draggable Text';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: offset.dx,
          top: offset.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                offset = Offset(
                    offset.dx + details.delta.dx, offset.dy + details.delta.dy);
              });
            },
            onDoubleTap: () {
              setState(() {
                isEditing = true;
              });
              _controller.selection = TextSelection(
                baseOffset: 0,
                extentOffset: _controller.text.length,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: isEditing
                  ? SizedBox(
                      width: 200, // Adjust the width as needed
                      child: TextField(
                        controller: _controller,
                        autofocus: true,
                        onSubmitted: (newValue) {
                          setState(() {
                            text = newValue;
                            isEditing = false;
                          });
                        },
                        onEditingComplete: () {
                          setState(() {
                            text = _controller.text;
                            isEditing = false;
                          });
                        },
                        style: TextStyle(
                          fontSize: textSize,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        fontSize: textSize,
                        color: Colors.black,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
