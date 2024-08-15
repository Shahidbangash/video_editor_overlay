import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor_overlay/views/picker/color_picker_plugin.dart';

class VerticalColorBar extends StatefulWidget {
  final List<Color> colors;
  // final ValueChanged<Color> onColorSelected;

  const VerticalColorBar({
    super.key,
    required this.colors,
  });

  @override
  State<VerticalColorBar> createState() => _VerticalColorBarState();
}

class _VerticalColorBarState extends State<VerticalColorBar> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final ColorPickerCubit colorPickerCubit = context.read<ColorPickerCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isExpanded)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 50,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: widget.colors.map((color) {
                return GestureDetector(
                  onTap: () {
                    colorPickerCubit.selectColor(color);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      // shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        if (isExpanded) const SizedBox(height: 3),
        MaterialButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.black,
          minWidth: 50,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
          ),
          child: const Icon(
            Icons.format_color_reset,
            color: Colors.white,
            size: 30,
          ),
        ),
      ],
    );
  }
}
