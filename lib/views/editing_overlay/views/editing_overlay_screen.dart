import 'package:flutter/material.dart';
import 'package:video_editor_overlay/components/editing_mode/editing_mode_widget.dart';
import 'package:video_editor_overlay/views/draggable/draggable_plugin.dart';
import 'package:video_editor_overlay/views/picker/color_picker_plugin.dart';

class EditingOverlayScreen extends StatelessWidget {
  const EditingOverlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Editor Overlay'),
      ),
      body: BlocBuilder<EditingModeCubit, EditingMode>(
        // bloc: ,
        builder: (context, state) {
          return Stack(
            children: [
              if (state == EditingMode.textDrag) const DraggableText(),
              if (state == EditingMode.curveDraw)
                const DrawCurveOverlay(), // Custom Painter for drawing lines

              const ColorPickerOverlay(), // Color picker
              const EditingModeOverlay(), // Editing mode selector
            ],
          );
        },
      ),
    );
  }
}
