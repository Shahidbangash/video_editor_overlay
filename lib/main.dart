import 'package:flutter/material.dart';
import 'package:video_editor_overlay/views/draggable/draggable_plugin.dart';
import 'package:video_editor_overlay/views/picker/component/color_picker.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Editor',
      home: Scaffold(
        body: Stack(
          children: [
            DrawCurveOverlay(), // Custom Painter for drawing lines

            // ColorPickerOverlay(), // Color picker
            // DraggableText(), // Draggable and resizable text
          ],
        ),
      ),
    );
  }
}
