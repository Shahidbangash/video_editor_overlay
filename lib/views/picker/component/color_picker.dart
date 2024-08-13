import 'package:flutter/material.dart';
import 'package:video_editor_overlay/common/constants.dart';
import 'package:video_editor_overlay/views/picker/component/selected_color_indicator.dart';
import 'package:video_editor_overlay/views/picker/component/vertical_color_bar.dart';

class ColorPickerOverlay extends StatefulWidget {
  const ColorPickerOverlay({super.key});

  @override
  State<ColorPickerOverlay> createState() => _ColorPickerOverlayState();
}

class _ColorPickerOverlayState extends State<ColorPickerOverlay> {
  Color selectedColor = Colors.black; // Default color

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.15,
          right: 20,
          child: Align(
            alignment: Alignment.centerLeft,
            child: VerticalColorBar(
              colors: colors,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SelectedColorIndicator(color: selectedColor),
          ),
        ),
      ],
    );
  }
}
